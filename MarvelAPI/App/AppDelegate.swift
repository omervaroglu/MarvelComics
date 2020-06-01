//
//  AppDelegate.swift
//  MarvelAPI
//
//  Created by Ömer Varoğlu on 31.05.2020.
//  Copyright © 2020 Omer Varoglu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        startApplication()
        return true
    }

    func startApplication() {
        let splashVC = SplashVC(nibName: "SplashVC", bundle: nil)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = splashVC
        window?.makeKeyAndVisible()
    }

}

