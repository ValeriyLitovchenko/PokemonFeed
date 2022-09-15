//
//  AppDelegate.swift
//  PokemonFeed
//
//  Created by Valeriy L on 15.09.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  // MARK: - Property
  
  var window: UIWindow?
  
  // MARK: - Functions
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = UIViewController()
    window?.makeKeyAndVisible()
    
    return true
  }
  
}
