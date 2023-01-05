//
//  AppDelegate.swift
//  NavigationControllerEnvironmentObject
//
//  Created by Maris Lagzdins on 05/01/2023.
//

import UIKit

@main
class AppDelegate: NSObject, UIApplicationDelegate {
    private var bootstrap: Bootstrap!

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        bootstrap = Bootstrap(window: window)
        bootstrap.start()

        return true
    }
}

