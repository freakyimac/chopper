//
//  AppDelegate.swift
//  Chopper
//
//  Created by 김동현 on 2023/04/24.
//

import UIKit
import SnapKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = PlayerViewController()
//        window?.rootViewController = TabBarViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
