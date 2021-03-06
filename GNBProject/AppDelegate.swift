//
//  AppDelegate.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = buildNavigationController()
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    private func buildNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: TransactionListBuilder.build())
    }

}

