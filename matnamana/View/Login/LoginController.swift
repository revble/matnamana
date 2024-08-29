//
//  LoginController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/23/24.
//

import UIKit
import RxSwift
import RxCocoa

class LoginController: UIViewController {
  private var loginView: LoginView?
  private let disposeBag = DisposeBag()
  
  override func loadView() {
    loginView = LoginView(frame: UIScreen.main.bounds)
    self.view = loginView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loginView?.loginButton.rx.tap
      .subscribe(onNext: { [weak self] in
        self?.startSignInWithAppleFlow()
      }).disposed(by: disposeBag)
  }
}
