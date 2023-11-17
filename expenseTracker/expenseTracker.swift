//
//  foldApp.swift
//  fold
//
//  Created by Admin on 11/11/23.
//

import SwiftUI
import Firebase
import FirebaseInAppMessaging
import FirebaseMessaging
import CoreData

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        // Other necessary configurations
        
        // Register for remote notifications
        UNUserNotificationCenter.current().delegate = self
        application.registerForRemoteNotifications()
        
        return true
    }
    
    // Handle remote notification registration
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Handle registration of remote notifications
        // You may want to pass this deviceToken to Firebase for handling notifications
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // Handle remote notification reception
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Forward the notification to FIRAuth's canHandleNotification method
        if let auth = Auth.auth() as? Auth {
            auth.canHandleNotification(userInfo)
        }
        
        // Handle other aspects of the notification if necessary
        // ...
        
        completionHandler(.newData)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // Handle notifications when the app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Handle foreground notifications
        
        completionHandler([.badge, .sound, .alert])
    }
    
    // Handle tap on notifications when the app is in the background or terminated
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        // Handle tapping on notifications
        
        // Forward the notification to FIRAuth's canHandleNotification method
        if let auth = Auth.auth() as? Auth {
            auth.canHandleNotification(userInfo)
        }
        
        // Handle other aspects of the notification if necessary
        // ...
        
        completionHandler()
    }
}

@main
struct expenseTracker: App {
    
    @StateObject var transactionViewModel = TransactionViewModel()
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @ObservedObject var appColor = AppColor()

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(transactionViewModel)
        }
    }
}

class AppColor: ObservableObject {
  @Published var tint:Color = .textColor
}
