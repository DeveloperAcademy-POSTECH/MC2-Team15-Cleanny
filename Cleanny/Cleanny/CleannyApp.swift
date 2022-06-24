//
//  CleannyApp.swift
//  Cleanny
//
//  Created by 종건 on 2022/06/08.
//

import SwiftUI

@main
struct CleannyApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    @StateObject var cleaning =  CleaningDataStore()
    @StateObject var userData = UserDataStore()
    @StateObject var MonthData = MonthDataStore()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(cleaning)
                .environmentObject(userData)
                .environmentObject(MonthData)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
