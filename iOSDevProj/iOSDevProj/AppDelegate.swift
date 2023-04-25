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
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .spotifyBlack
        window?.makeKeyAndVisible()
        
        let navigatorController = UINavigationController(rootViewController: HomeController())
        window?.rootViewController = navigatorController

//        window?.rootViewController = HomeController()

        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .spotifyBlack

        return true
    }


}
