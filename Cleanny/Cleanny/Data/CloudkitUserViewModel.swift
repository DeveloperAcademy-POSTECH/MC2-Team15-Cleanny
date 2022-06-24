
//  CloudkitUserViewModel.swift
//  Cleanny
//
//  Created by 이채민 on 2022/06/14.


import Foundation
import CloudKit
import OSLog

@MainActor
final class CloudkitUserViewModel: ObservableObject {

    enum ViewModelError: Error {
        case invalidRemoteShare
    }

    enum State {
        case loading
        case loaded(me: [CloudkitUser], friends: [CloudkitUser])
        case error(Error)
    }

    @Published private(set) var state: State = .loading
    lazy var container = CKContainer(identifier: Config.containerIdentifier)
    private lazy var database = container.privateCloudDatabase
    let sharingZone = CKRecordZone(zoneName: "SharingZone")

    nonisolated init() {}

    init(state: State) {
        self.state = state
    }

    func initialize() async throws {
        do {
            try await createZoneIfNeeded()
        } catch {
            state = .error(error)
        }
    }

    func refresh() async throws {
        state = .loading
        do {
            let (me, friends) = try await fetchPrivateAndSharedUsers()
            state = .loaded(me: me, friends: friends)
        } catch {
            state = .error(error)
        }
    }

    func fetchPrivateAndSharedUsers() async throws -> (me: [CloudkitUser], friends: [CloudkitUser]) {
        async let me = fetchUsers(scope: .private, in: [sharingZone])
        async let friends = fetchSharedUsers()

        return (me: try await me, friends: try await friends)
    }

    func addUser(name: String, totalPercentage: Double) async throws {
        let id = CKRecord.ID(zoneID: sharingZone.zoneID)
        let userRecord = CKRecord(recordType: "CloudkitUser", recordID: id)
        userRecord["name"] = name
        userRecord["totalPercentage"] = totalPercentage

        try await database.save(userRecord)
    }

    func updateUser(user: CloudkitUser, name: String, totalPercentage: Double) {
        let userRecord = user.associatedRecord
        userRecord["name"] = name
        userRecord["totalPercentage"] = totalPercentage

        database.save(userRecord) { [weak self] returnedRecord, returnedError in
            print("Record: \(String(describing: returnedRecord))")
            print("Error: \(String(describing: returnedError))")
        }
    }

    func fetchOrCreateShare(user: CloudkitUser) async throws -> (CKShare, CKContainer) {
        guard let existingShare = user.associatedRecord.share else {
            let share = CKShare(rootRecord: user.associatedRecord)
            let _ = print(user.name)
            share[CKShare.SystemFieldKey.title] = "친구의 청소 상태를 공유받으세요!ㅎㅁㅎ"
            _ = try await database.modifyRecords(saving: [user.associatedRecord, share], deleting: [])
            return(share, container)
        }

        guard let share = try await database.record(for: existingShare.recordID) as? CKShare else {
            throw ViewModelError.invalidRemoteShare
        }

        return (share, container)
    }

    private func fetchUsers(scope: CKDatabase.Scope, in zones: [CKRecordZone]) async throws -> [CloudkitUser] {
        let database = container.database(with: scope)
        var allCloudkitUsers: [CloudkitUser] = []

        @Sendable func usersInZone(_ zone: CKRecordZone) async throws -> [CloudkitUser] {
            var allUsers: [CloudkitUser] = []
            var awaitingChanges = true
            var nextChangeToken: CKServerChangeToken? = nil

            while awaitingChanges {
                let zoneChanges = try await database.recordZoneChanges(inZoneWith: zone.zoneID, since: nextChangeToken)
                let users = zoneChanges.modificationResultsByID.values
                    .compactMap { try? $0.get().record }
                    .compactMap { CloudkitUser(record: $0)}
                allUsers.append(contentsOf: users)
                awaitingChanges = zoneChanges.moreComing
                nextChangeToken = zoneChanges.changeToken
            }

            return allUsers
        }

        try await withThrowingTaskGroup(of: [CloudkitUser].self) { group in
            for zone in zones {
                group.addTask {
                    try await usersInZone(zone)
                }
            }

            for try await usersResult in group {
                allCloudkitUsers.append(contentsOf: usersResult)
            }
        }

        return allCloudkitUsers
    }

    private func fetchSharedUsers() async throws -> [CloudkitUser] {
        let sharedZones = try await container.sharedCloudDatabase.allRecordZones()
        guard !sharedZones.isEmpty else {
            return[]
        }

        return try await fetchUsers(scope: .shared, in: sharedZones)
    }

    private func createZoneIfNeeded() async throws {
        guard !UserDefaults.standard.bool(forKey: "isZoneCreated") else {
            return
        }

        do {
            _ = try await database.modifyRecordZones(saving: [sharingZone], deleting: [])
        } catch {
            print("ERROR: Failed to create custom zone: \(error.localizedDescription)")
            throw error
        }

        UserDefaults.standard.setValue(true, forKey: "isZoneCreated")
    }
}

enum Config {
    static let containerIdentifier = "iCloud.testCloud.juju"
}
