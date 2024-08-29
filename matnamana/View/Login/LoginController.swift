//
//  LoginController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/23/24.
//

import UIKit

import RxCocoa
import RxSwift

final class LoginController: UIViewController {
  
  private var loginView = LoginView(frame: .zero)
  private let disposeBag = DisposeBag()
  
  override func loadView() {
    loginView = LoginView(frame: UIScreen.main.bounds)
    self.view = loginView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loginView.loginButton.rx.tap
      .subscribe(onNext: { [weak self] in
        self?.startSignInWithAppleFlow()
      }).disposed(by: disposeBag)
  }
}
