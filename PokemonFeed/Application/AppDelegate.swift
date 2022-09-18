//
//  AppDelegate.swift
//  PokemonFeed
//
//  Created by Valeriy L on 15.09.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  // MARK: - Properties
  
  var window: UIWindow?
  
  private lazy var appFlowCoordinator = AppFlowCoordinator(navigationController: UINavigationController())
  
  // MARK: - Functions
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = appFlowCoordinator.navigationController
    appFlowCoordinator.start()
    
    setupNAvigationBarAppearance()
    
    window?.makeKeyAndVisible()
    
    return true
  }
  
  // MARK: - Private functions
  private func setupNAvigationBarAppearance() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .white
    appearance.backgroundEffect = .none
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    UINavigationBar.appearance().standardAppearance = appearance
  }
}
