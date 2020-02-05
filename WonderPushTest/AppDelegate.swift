//
//  AppDelegate.swift
//  WonderPushTest
//
//  Created by hitesh on 05/02/20.
//  Copyright © 2020 hitesh. All rights reserved.
//

import UIKit
import CoreData
import WonderPush
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , UNUserNotificationCenterDelegate{
    var window:UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        WonderPush.setClientId(WonderPushCredentials.clientId.rawValue, secret: WonderPushCredentials.clientSecret.rawValue)
        WonderPush.setupDelegate(for: application)
        WonderPush.setupDelegateForUserNotificationCenter()
        
        NotificationCenter.default.addObserver(self, selector: #selector(registerApns), name: NotificationNames.RegisterNotification, object: nil)
        
        return true
    }
    
    //MARK:- registerApns
    @objc func registerApns()
    {
        // Register for remote notifications. This shows a permission dialog on first run, to
        // show the dialog at a more appropriate time move this registration accordingly.

        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound, .badge]) {
            [weak self] granted, error in
            
            print("Permission granted: \(granted)")
            guard granted else {
                return
            }
            WonderPushHandler.subscribe()
            self?.getNotificationSettings()
        }

    }
    
    func getNotificationSettings() {
           UNUserNotificationCenter.current().getNotificationSettings { settings in
               guard settings.authorizationStatus == .authorized else { return }
               DispatchQueue.main.async {
                   UIApplication.shared.registerForRemoteNotifications()
               }
           }
       }

    
    // MARK:- Notification methods
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {

            // If you are receiving a notification message while your app is in the background,
            // this callback will not be fired till the user taps on the notification launching the application.

            // Print full message.
            print(userInfo)

        }
        
        //MARK: Notification Methods-
        func application(_ application: UIApplication,
                         didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

            let token =  deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
            print("Device Token: \(token)")//print device token in debugger console
        }

        func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
            print("Unable to register for remote notifications: \(error.localizedDescription)")
        }
        
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

            NSLog("User Info : %@",notification.request.content.userInfo)

            if UIApplication.shared.applicationState == .active {
                completionHandler([.alert, .badge, .sound])
            }
        }

        // Receive displayed notifications for iOS 10 devices.
        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive resRPUsernse: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

            let userInfo = resRPUsernse.notification.request.content.userInfo
            NSLog("User Info : %@",userInfo)

            completionHandler()
        }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "WonderPushTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

