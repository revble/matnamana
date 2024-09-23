//
//  LoginController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/23/24.
//

import UIKit

import FirebaseAuth
import KakaoSDKAuth
import KakaoSDKUser
import RxCocoa
import RxSwift

final class LoginController: BaseViewController {
  
  private var loginView = LoginView(frame: .zero)
  private let loginviewModel = LoginViewModel()
  var namevalue = true
  
  override func setupView() {
    super.setupView()
    loginView = LoginView(frame: UIScreen.main.bounds)
    self.view = loginView
  }
  
  override func bind() {
    super.bind()
    let input = LoginViewModel.Input(
      loggedInApple: loginView.loginButton.rx.controlEvent(.touchUpInside),
      loggedInKakao: loginView.kakaoLoginButton.rx.tap
    )
    
    let output = loginviewModel.transform(input: input)
    
    output.isDuplicate
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] isDuplicate in
        guard let self else { return }
        if isDuplicate {
          self.transitionToViewController(TabBarController())
        } else {
          output.appleLoggin
            .subscribe(onNext: { [weak self] bool in
              guard let self else { return }
              if bool {
                self.transitionToViewController(RequiredInformationController(appleLogin: true))
              } else {
                self.transitionToViewController(RequiredInformationController(appleLogin: false))
              }
            }).disposed(by: self.disposeBag)
        }
      }).disposed(by: disposeBag)
  }
}
