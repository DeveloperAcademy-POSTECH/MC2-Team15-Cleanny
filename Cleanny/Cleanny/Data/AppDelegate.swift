//
//  AppDelegate.swift
//  (cloudkit-samples) Sharing
//

import UIKit
import CoreData

//@main
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        let sceneConfig = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    /*
    var persistentContainer: NSPersistentContainer {
        
            let container = NSPersistentCloudKitContainer(name: "User")
            container.loadPersistentStores(completionHandler: {
                (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
    }
    */
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "User")
        
        // Create a store description for a local store
        let localStoreLocation = URL(fileURLWithPath: "/path/to/local.store")
        let localStoreDescription =
            NSPersistentStoreDescription(url: localStoreLocation)
        localStoreDescription.configuration = "Local"
        
        // Create a store description for a CloudKit-backed local store
        let cloudStoreLocation = URL(fileURLWithPath: "/path/to/cloud.store")
        let cloudStoreDescription =
            NSPersistentStoreDescription(url: cloudStoreLocation)
        cloudStoreDescription.configuration = "Cloud"

        // Set the container options on the cloud store
        cloudStoreDescription.cloudKitContainerOptions =
            NSPersistentCloudKitContainerOptions(
                containerIdentifier: "com.cloudkit.sample.CloudKitCore")
        
        // Update the container's list of store descriptions
        container.persistentStoreDescriptions = [
            cloudStoreDescription,
            localStoreDescription
        ]
        
        // Load both stores
        container.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError("Could not load persistent stores. \(error!)")
            }
        }
        
        return container
    }()
}
