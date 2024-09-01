//
//  SceneDelegate.swift
//  matnamana
//
//  Created by 김윤홍 on 8/23/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: windowScene)
    
    let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    
    if isLoggedIn {
      window.rootViewController = TabBarController()
    } else {
      window.rootViewController = LoginController()
    }
    window.makeKeyAndVisible()
    
    self.window = window
  }
}
