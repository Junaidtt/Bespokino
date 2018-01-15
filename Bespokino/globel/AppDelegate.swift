//
//  AppDelegate.swift
//  Bespokino
//
//  Created by Bespokino on 11/5/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import GooglePlaces
import StoreKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let reachability = Reachability();

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        GMSPlacesClient.provideAPIKey("AIzaSyB7pl3-VkABUpwFs60eGCFoh7gtEWBikT4")

        
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        UINavigationBar.appearance().isTranslucent = false
        
         IQKeyboardManager.sharedManager().enable = true
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged), name: Notification.Name.reachabilityChanged , object: reachability)
        do{
            
            try reachability?.startNotifier()
        }catch{
            print("Could not start notifier:\(error)")
        }
      
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "isRegIn")
        defaults.set(false, forKey: "isLoggedIn")
        defaults.synchronize()
        return true
    }
    @objc func internetChanged(note:Notification)  {
        let reachability  = note.object as! Reachability
        
        if reachability.connection != .none {
            print("Yes, internet connection")

            if reachability.connection == .wifi{
                print("Wifi connection")

            }else if reachability.connection == .cellular{
                 print("cellular connection")
            }
        }else{
            print("No internet connection")
            

            self.displayAlert()
            
        }
    }
    
    func requestReview()   {
        
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {

            print("Rating disabled")
        
        }
        
    }
    
    func displayAlert()  {
        let topWindow = UIWindow(frame: UIScreen.main.bounds)
        topWindow.rootViewController = UIViewController()
        topWindow.windowLevel = UIWindowLevelAlert + 1
        let alert = UIAlertController(title: "No Internet", message: "please check your internet connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "confirm"), style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
            // continue your work
            // important to hide the window after work completed.
            // this also keeps a reference to the window until the action is invoked.
            topWindow.isHidden = true
        }))
        topWindow.makeKeyAndVisible()
        topWindow.rootViewController?.present(alert, animated: true, completion: nil)
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        print("Application terminated")
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "isRegIn")
        defaults.synchronize()
        self.saveContext()
    }

    // MARK: - Core Data stack

    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Bespokino")
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
