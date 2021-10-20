//
//  AppDelegate.swift
//  Messager
//
//  Created by minmin on 2021/09/29.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var firstRun: Bool?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        firstRunCheck()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
 
    }

    // MARK: - FirstRun

    private func firstRunCheck() {
        firstRun = userDefaults.bool(forKey: kFIRSTRUN)
        if !firstRun! {
print("this is first run")
            let status = Status.allCases.map{ $0.rawValue }
            userDefaults.set(status, forKey: kSTATUS)
            userDefaults.set(true, forKey: kFIRSTRUN)

        }
    }


}

