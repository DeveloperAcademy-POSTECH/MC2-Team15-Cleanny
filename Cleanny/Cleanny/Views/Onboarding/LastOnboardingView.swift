//
//  LastOnboardingView.swift
//  Cleanny
//
//  Created by 이채민 on 2022/06/17.
//

import SwiftUI
import CloudKit

class GetCloudName: ObservableObject {
    
    @Published var permissionStatus: Bool = false
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    @Published var userName: String = ""

    init() {
        getiCloudStatus()
        requestPermission()
        fetchiCloudUserRecordID()
    }
    private func getiCloudStatus(){
        CKContainer.default().accountStatus { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                switch returnedStatus {
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAccountNotDetermined.rawValue
                    break
                case .available:
                    self?.isSignedInToiCloud = true
                    break
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountRestricted.rawValue
                    break
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                    break
                default:
                    self?.error = CloudKitError.iCloudAccountUnknown.rawValue
                    break
                }
            }
        }
    }
    
    enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
    }
    
    func requestPermission() {
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                if returnedStatus == .granted {
                    self?.permissionStatus = true
                }
            }
        }
    }
    
    func fetchiCloudUserRecordID() {
        CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in
            if let id = returnedID {
                self?.discoveriCloudUser(id: id)
            }
        }
    }
    func discoveriCloudUser(id: CKRecord.ID) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] returnedIdentity, returnedError in
            DispatchQueue.main.async {
                if let name = returnedIdentity?.nameComponents?.givenName {
                    self?.userName = name
                }
            }
        }
    }
}

struct LastOnboardingView: View {
    
    @Binding var firstLaunching: Bool
    
    @StateObject private var vm = GetCloudName()
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.name, ascending: true)],
        animation: .default)
    private var users: FetchedResults<User>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Clean.index, ascending: true)],
        animation: .default)
    private var cleans: FetchedResults<Clean>
    
    var body: some View {
        VStack {
            
            Text("온보딩 테스트 페이지")
            Text("IS SIGNED IN: \(vm.isSignedInToiCloud.description.uppercased())")
            Text(vm.error)
            Text("Permission: \(vm.permissionStatus.description.uppercased())")
            Text("NAME: \(vm.userName)")
            
            Button {
                addUser(userName: vm.userName)
                addBasicClean()
            } label: {
                Text("등록하기")
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color("MBlue"))
                    .cornerRadius(10)
            }
            Button {
                firstLaunching.toggle()
            } label: {
                Text("시작하기")
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color("MBlue"))
                    .cornerRadius(10)
            }
            List {
//                ForEach(users) {user in
//                    HStack{
//                        Text(user.name ?? "nil")
//                        Text(String(user.totalPercentage))
//                        Text(String(user.numerator))
//                        Text(String(user.denomirator))
//                    }
//                }.onDelete(perform: deleteUsers)
            }.frame(height: 100)
            List{
//                ForEach(cleans) {clean in
//                    HStack{
//                        Text(clean.name ?? "nil")
//                        Text(clean.imageName ?? "nil")
//                        Text(String(clean.activated))
//                        Text(String(clean.cycle))
//                        Text(String(clean.decreaseRate))
//                        Text(String(clean.currentPercent))
////                            Text(String(clean.savedTime))
//                        Text(String(clean.index))
//                    }
//                }.onDelete(perform: deleteCleans)
            }
        }
    }
    
    func addUser(userName: String) {
        withAnimation {
            let newUser = User(context: viewContext)
            newUser.name = userName
            newUser.totalPercentage = 99.9
            newUser.denominator = 1
            newUser.numerator = 1

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    func addBasicClean() {
        let list = [
            Cleaning(name: "분리수거", imageName:"DisposeTrash", activated: true, cycle: 3, decreaseRate:0.0003858, currentPercent: 99.999, index: 0),
            Cleaning(name: "세탁", imageName:"Laundary", activated: true, cycle: 3, decreaseRate:0.0003858, currentPercent: 99.999, index: 1),
            Cleaning(name: "욕실청소", imageName:"ToiletCleaning", activated: true, cycle: 3, decreaseRate:0.0003858, currentPercent: 99.999, index: 2),
            Cleaning(name: "바닥청소", imageName:"FloorCleaning", activated: true, cycle: 3, decreaseRate:0.0003858, currentPercent: 99.999,index: 3),
            Cleaning(name: "설거지", imageName:"DishWashing", activated: true, cycle: 3, decreaseRate:0.0003858, currentPercent: 99.999,index: 4),
            Cleaning(name: "정리정돈", imageName:"TidyUp", activated: true, cycle: 3, decreaseRate:0.0003858, currentPercent: 99.999,index: 5)
        ]
        withAnimation {
            list.forEach { cleaning in
                let newClean = Clean(context: viewContext)
                newClean.name = cleaning.name
                newClean.imageName = cleaning.imageName
                newClean.activated = cleaning.activated
                newClean.cycle = cleaning.cycle
                newClean.decreaseRate = cleaning.decreaseRate
                newClean.currentPercent = cleaning.currentPercent
                newClean.savedTime = cleaning.savedTime
                newClean.index = Int16(cleaning.index)
                
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    }
    private func deleteUsers(offsets: IndexSet) {
        withAnimation {
            offsets.map { users[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    private func deleteCleans(offsets: IndexSet) {
        withAnimation {
            offsets.map { cleans[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
