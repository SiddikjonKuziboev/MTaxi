//
//  AppDelegate.swift
//  Taxi
//
//  Created by Kuziboev Siddikjon on 12/17/21.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey(Constant.map_key)
        
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "left_arrow")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "left_arrow")
        
        window = UIWindow()
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        let vc = MainVC(nibName: "MainVC", bundle: nil)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
      
        return true
    }



}
