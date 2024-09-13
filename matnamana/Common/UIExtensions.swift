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
  
  func pushViewController(_ viewController: UIViewController) {
    navigationController?.pushViewController(viewController, animated: true)
  }
  func popViewController() {
    navigationController?.popViewController(animated: true)
  }
  
  func presentModally(
    _ viewController: UIViewController,
    animated: Bool = true,
    modalPresentationStyle: UIModalPresentationStyle = .formSheet
  ) {
    viewController.modalPresentationStyle = modalPresentationStyle
    self.present(viewController, animated: animated)
  }
}

extension UIView {
  func setupShadow() {
    self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06)
    self.layer.cornerRadius = 10
    self.layer.masksToBounds = false
    self.layer.shadowOpacity = 1
    self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
    self.layer.shadowOffset = CGSize(width: 2, height: 2)
    self.layer.shadowRadius = 2
  }
}
