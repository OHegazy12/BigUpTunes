//
//  AppDelegate.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 4/25/23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        if AuthManager.shared.isSignedIn
        {
            AuthManager.shared.refreshIfNeeded(completion: nil)
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.backgroundColor = .systemBackground
            window?.makeKeyAndVisible()
    
            let navigatorController = UINavigationController(rootViewController: TabBarViewController())
            window?.rootViewController = navigatorController

            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().barTintColor = .spotifyBlack
        }
        else
        {
            let navVC = UINavigationController(rootViewController: WelcomeViewController())
            navVC.navigationBar.prefersLargeTitles = true
            navVC.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
            window?.rootViewController = navVC
        }

        return true
    }


}
