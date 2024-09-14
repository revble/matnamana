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
  static let manaMainColor = UIColor(red: 0/255, green: 168/255, blue: 226/255, alpha: 1)
  static let manatextColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
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
    self.layer.masksToBounds = false
    self.layer.shadowOpacity = 0.2
    self.layer.shadowOffset = CGSize(width: 2, height: 2)
    self.layer.shadowRadius = 2
  }
}

extension UILabel {
  func screenTitle(fontSize: CGFloat = 34) {
    self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
  }
  
  func title1(fontSize: CGFloat = 28) {
    self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
  }
  
  func title2(fontSize: CGFloat = 22) {
    self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
  }
  
  func title3(fontSize: CGFloat = 20) {
    self.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
  }
  
  func headLine(fontSize: CGFloat = 17) {
    self.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
  }
  
  func bonmoon(fontSize: CGFloat = 17) {
    self.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
  }
  
  func callOut(fontSize: CGFloat = 16) {
    self.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
  }
  
  func subHeadLine(fontSize: CGFloat = 15) {
    self.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
  }
  
  func footNote(fontSize: CGFloat = 13) {
    self.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
  }
  
  func caption(fontSize: CGFloat = 12) {
    self.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
  }
}
