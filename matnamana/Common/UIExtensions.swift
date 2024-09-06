//
//  Ex+UIColor.swift
//  matnamana
//
//  Created by 김윤홍 on 8/29/24.
//

import UIKit

extension UIColor {
  static let manaPink = UIColor(red: 255/255, green: 197/255, blue: 197/255, alpha: 1)
  static let manaSkin = UIColor(red: 255/255, green: 235/255, blue: 216/255, alpha: 1)
  static let manaMint = UIColor(red: 199/255, green: 220/255, blue: 167/255, alpha: 1)
  static let manaGreen = UIColor(red: 137/255, green: 185/255, blue: 173/255, alpha: 1)
}
extension UIViewController {
  func transitionToViewController(_ viewController: UIViewController) {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first else { return }
    window.rootViewController = viewController
    window.makeKeyAndVisible()
  }
}
