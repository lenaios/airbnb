//
//  SceneDelegate.swift
//  Airbnb
//
//  Created by Ador on 2021/07/13.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  var coordinator: Coordinator?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    let nav = UINavigationController()
    nav.navigationBar.tintColor = .systemPink
    window?.rootViewController = nav
    coordinator = MainCoordinator(navigationController: nav)
    coordinator?.start()
    window?.makeKeyAndVisible()
  }
}

