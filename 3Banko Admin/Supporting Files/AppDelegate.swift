//
//  AppDelegate.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 2.11.2020.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        let email = " " //Admin email
        let passWord = " " //Admin password
        
        if Auth.auth().currentUser == nil {
            FirebaseManager.shared.authAdminWith(email: email, password: passWord) { (uid, error) in
                if let error = error {
                    print("DEBUG: Error with admin login \(error)")
                } else {
                    guard let uid = uid else { return }
                    print("DEBUG: Succesfully login with uid: \(uid)")
                }
            }
        } else {
            print("DEBUG: Already succesfully login with uid: \(String(describing: Auth.auth().currentUser?.uid))")
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

