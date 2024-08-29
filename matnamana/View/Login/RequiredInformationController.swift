//
//  LoginController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/23/24.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth

class RequiredInformationController: UIViewController {
  private var requiredInformationView: RequiredInformationView?
  private let disposeBag = DisposeBag()
  
  override func loadView() {
    requiredInformationView = RequiredInformationView(frame: UIScreen.main.bounds)
    self.view = requiredInformationView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    userInfo()
  }
  ///
  func userInfo() {
    let user = Auth.auth().currentUser
    if let user = user {
      // The user's ID, unique to the Firebase project.
      // Do NOT use this value to authenticate with your backend server,
      // if you have one. Use getTokenWithCompletion:completion: instead.
      let uid = user.uid
      print(uid)
      let email = user.email
      print(email)
      let photoURL = user.photoURL
      print(photoURL)
      var multiFactorString = "MultiFactor: "
      for info in user.multiFactor.enrolledFactors {
        multiFactorString += info.displayName ?? "[DispayName]"
        multiFactorString += " "
      }
      // ...
    }
  }
  
  
}