//
//  SceneDelegate.swift
//  matnamana
//
//  Created by 김윤홍 on 8/23/24.
//
//
//import UIKit
//
//import KakaoSDKAuth
//
//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//
//  var window: UIWindow?
//
//  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//
//    guard let windowScene = (scene as? UIWindowScene) else { return }
//    let window = UIWindow(windowScene: windowScene)
//
//<<<<<<< Updated upstream
//    let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
//    
//=======
//   let isLoggedIn = false//UserDefaults.standard.bool(forKey: "isLoggedIn")
//
//>>>>>>> Stashed changes
//    if isLoggedIn {
//      window.rootViewController = TabBarController()
//    } else {
//      window.rootViewController = LoginController()
//    }
//<<<<<<< Updated upstream
//    
//    UserDefaults.standard.set("UzhyIQp6J2a0JxORcwabPec4qUf1", forKey: "loggedInUserId")
//    
//=======
//   // window.rootViewController = TabBarController()
////    UserDefaults.standard.set("UzhyIQp6J2a0JxORcwabPec4qUf1", forKey: "loggedInUserId")
//
//>>>>>>> Stashed changes
//    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//      window.makeKeyAndVisible()
//    }
//    self.window = window
//  }
//
//  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
//    if let url = URLContexts.first?.url {
//      if (AuthApi.isKakaoTalkLoginUrl(url)) {
//        _ = AuthController.handleOpenUrl(url: url)
//      }
//    }
//  }
//}

import UIKit

import KakaoSDKAuth

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

    UserDefaults.standard.set("WIz5GY8obiXPngauYYhI7OcCyLr1", forKey: "loggedInUserId")

    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
      window.makeKeyAndVisible()
    }
    self.window = window
  }

  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    if let url = URLContexts.first?.url {
      if (AuthApi.isKakaoTalkLoginUrl(url)) {
        _ = AuthController.handleOpenUrl(url: url)
      }
    }
  }
}
