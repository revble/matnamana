//
//  LoginController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/23/24.
//

import UIKit

import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import RxCocoa
import RxSwift

final class RequiredInformationController: UIViewController {
  
  private var requiredInformationView = RequiredInformationView(frame: .zero)
  private let disposeBag = DisposeBag()
  private let requiredInfoViewModel = RequiredInfoViewModel()
  
  override func loadView() {
    requiredInformationView = RequiredInformationView(frame: UIScreen.main.bounds)
    self.view = requiredInformationView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindJoinButton()
    bindViewModel()
  }
  
  private func bindJoinButton() {
    requiredInformationView.joinButton.rx.tap
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        let nickName = self.requiredInformationView.pickNickname()
        self.requiredInfoViewModel.checNicknameDuplicate(nickname: nickName)
      }).disposed(by: disposeBag)
  }
  
  private func bindViewModel() {
    requiredInfoViewModel.isNicknameDuplicate
      .subscribe(onNext: {  [weak self] isDuplicate in
        guard let self = self else { return }
        if isDuplicate {
          self.requiredInformationView.showduplicateCheck()
        } else {
          self.requiredInformationView.hideduplicateCheck()
          self.alertMessage()
          self.requiredInfoViewModel.makeUserInformation(
            name: self.requiredInformationView.pickName(),
            nickName: self.requiredInformationView.pickNickname()) { user in
              self.requiredInfoViewModel.saveLoginState(userId: user.userId)
            }
        }
      }).disposed(by: disposeBag)
  }

  private func alertMessage() {
    let alertMessage = UIAlertController(title: "가입을 환영합니다!",
                                         message: "나만의 탁월한 질문을 만들어 보세요!",
                                         preferredStyle: .alert)
    let okAction = UIAlertAction(title: "이동하기", style: .default) {_ in
      self.transitionToViewController(TabBarController())
    }
    alertMessage.addAction(okAction)
    present(alertMessage, animated: true, completion: nil)
  }
  
  private func transitionToViewController(_ viewController: UIViewController) {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first else { return }
    window.rootViewController = viewController
    window.makeKeyAndVisible()
  }
}
