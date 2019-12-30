//
//  AppDelegate.swift
//  Test
//
//  Created by Suryanarayan Sahu on 30/12/19.
//  Copyright © 2019 Suryanarayan Sahu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //---Start Checcking for Network
        ReachabilityHelper.shared.startMonitoring()
        
        //---Assign memory to Window
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        //---Assign Controller to Window
        let nextViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let navigationController = UINavigationController(rootViewController: nextViewController)
        self.window?.rootViewController = navigationController

        return true
    }



}

