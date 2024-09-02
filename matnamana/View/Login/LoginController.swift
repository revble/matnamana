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


final class LoginController: UIViewController {
  
  private var loginView = LoginView(frame: .zero)
  private let disposeBag = DisposeBag()
  private let loginviewModel = LoginViewModel()
  
  override func loadView() {
    loginView = LoginView(frame: UIScreen.main.bounds)
    self.view = loginView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindLoginViewModel()
    loginView.kakaoLoginButton.rx.tap
      .subscribe(onNext: { _ in
        KakaoLoginService.shared.KakaoLogin()
      }).disposed(by: disposeBag)
  }
  

  
  func bindLoginViewModel() {
    let input = LoginViewModel.Input(
      loginButtonTap: loginView.loginButton.rx.tap.asObservable()
    )
    let output = loginviewModel.transform(input: input)
    
    output.isDuplicate
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { isDuplicate in
        if isDuplicate {
          self.transitionToViewController(TabBarController())
        } else {
          self.transitionToViewController(RequiredInformationController())
        }
      }).disposed(by: disposeBag)
  }
  
  private func transitionToViewController(_ viewController: UIViewController) {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first else { return }
    window.rootViewController = viewController
    window.makeKeyAndVisible()
  }
}
