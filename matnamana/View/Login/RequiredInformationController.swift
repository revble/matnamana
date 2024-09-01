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


class RequiredInformationController: UIViewController {
  
  private var requiredInformationView = RequiredInformationView(frame: .zero)
  private let disposeBag = DisposeBag()
//  private let requiredInformationViewModel = RequiredInformaitionViewModel()
  
  override func loadView() {
    requiredInformationView = RequiredInformationView(frame: UIScreen.main.bounds)
    self.view = requiredInformationView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    requiredInformationView.joinButton.rx.tap
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        self.checkNicknameDuplicate()
//        self.makeUserInformation()
//        self.transitionToViewController(TabBarController())
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
  
  private func checkNicknameDuplicate() {
    let db = FirebaseManager.shared.db
    let nickName = requiredInformationView.pickNickname()
    print(nickName)
    db.collection("users").whereField("info.nickName", isEqualTo: nickName).getDocuments { querySnapshot, error in
      if let error = error {
        print("Error")
        return
      }
      if let querySnapshot = querySnapshot, !querySnapshot.documents.isEmpty {
        print("중복된 닉네임이 존재합니다.")
        self.requiredInformationView.showduplicateCheck()
      } else {
        print("중복된 닉네임이 없습니다.")
        self.alertMessage()
        self.makeUserInformation()
        
        
        guard let user = Auth.auth().currentUser else { return }
        self.saveLoginState(userId: user.uid)
      }
    }
  }
  
  private func saveLoginState(userId: String) {
    UserDefaults.standard.set(true, forKey: "isLoggedIn")
    UserDefaults.standard.set(userId, forKey: "loggedInUserId")
    print("로그인 상태가 저장되었습니다.")
  }
  
  
  private func makeUserInformation() {
    guard let appleUser = Auth.auth().currentUser else { return }
    let user = User(
        info: User.Info(
            career: "",
            education: "",
            email: "",
            location: "",
            name: requiredInformationView.pickName(),
            phoneNumber: "",
            shortDescription: "",
            profileImage: "",
            nickname: requiredInformationView.pickNickname()
        ),
        preset: [],
        friendList: [],
        userId: appleUser.uid,
        reputationId: ""
    )
    FirebaseManager.shared.addUser(user: user)
  }
  
  private func transitionToViewController(_ viewController: UIViewController) {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first else { return }
    window.rootViewController = viewController
    window.makeKeyAndVisible()
  }
  
}
