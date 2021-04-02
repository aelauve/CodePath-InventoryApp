//
//  AppDelegate.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 2/20/21.
//

import UIKit
import Parse


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // --- Copy this only
            
            let parseConfig = ParseClientConfiguration {
                    $0.applicationId = "9BvGHePG5G25k2yXr8ID67QzRAiuynWK7ItTqzX1" // <- UPDATE
                    $0.clientKey = "h5G01WUAvoEikpT0aQpGwFkxpoCAzBhZkOaDnjlv" // <- UPDATE
                    $0.server = "https://parseapi.back4app.com"
            }
            Parse.initialize(with: parseConfig)
            
            // --- end copy

        let pageControl = UIPageControl.appearance()
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 0.5132452846, blue: 0.6042660475, alpha: 1)
        pageControl.pageIndicatorTintColor = .lightGray
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }



}

