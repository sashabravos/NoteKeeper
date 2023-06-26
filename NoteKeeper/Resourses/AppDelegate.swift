//
//  AppDelegate.swift
//  NoteKeeper
//
//  Created by Александра Кострова on 15.05.2023.
//

import UIKit
import CoreData
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        do {
            
            let realmConfig = Realm.Configuration(
                schemaVersion: 1,
                migrationBlock: { migration, oldSchemaVersion in
                    if oldSchemaVersion < 1 {
                        migration.enumerateObjects(ofType: Item.className()) { _, newObject in
                            newObject!["dateCreated"] = Date()
                        }
                    }
                }
            )

            Realm.Configuration.defaultConfiguration = realmConfig

            let realm = try Realm()
        } catch {
            print("Error initializing new realm \(error)")
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

      func application(_ application: UIApplication,
                       configurationForConnecting connectingSceneSession: UISceneSession,
                       options: UIScene.ConnectionOptions) -> UISceneConfiguration {
          
          return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
      }

      func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
      }

  }
