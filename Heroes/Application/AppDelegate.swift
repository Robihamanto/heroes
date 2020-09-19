//
//  AppDelegate.swift
//  Heroes
//
//  Created by Robihamanto on 15/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = UINavigationController()
        let mainDependencies = MainSceneDIContainer()
        
        coordinator = MainCoordinator(navigationController: navigationController, dependencies: mainDependencies)
        coordinator?.start()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
               
        return true
    }

}

