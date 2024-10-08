//
//  ProfileViewController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/29/24.
//

import UIKit

import RxCocoa
import RxSwift

final class ProfileViewController: BaseViewController {
  
  private var profileView = ProfileView(frame: .zero)
  private var viewModel = UserProfileViewModel()
  var userInfo: String
  var userImage: String?
  
  init(userInfo: String) {
    self.userInfo = userInfo
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setupView() {
    super.setupView()
    profileView = ProfileView(frame: UIScreen.main.bounds)
    self.view = profileView
  }
  
  override func bind() {
    super.bind()
    buttonClicked()
    let input = UserProfileViewModel.Input(fetchUser: Observable.just(()), nickName: userInfo)
    let output = viewModel.transform(input: input)
    
    guard let userId = UserDefaults.standard.string(forKey: "loggedInUserId") else { return }
    FirebaseManager.shared.readUser(documentId: userId) { [weak self] documentSnapshot, error in
      guard let self else { return }
      guard let snapshot = documentSnapshot else { return }
      let isFriend = snapshot.friendList.contains { $0.friendId == self.userInfo && $0.status != .rejected }
      
      if isFriend {
        self.profileView.requestFriend.isHidden = true
      } else if self.userInfo == snapshot.info.nickName {
        self.profileView.requestFriend.isHidden = true
        self.profileView.requestReference.isHidden = true
      } else {
        self.profileView.deleteFriend.isHidden = true
      }
    }
    
    output.userInfo
      .drive(onNext: { [weak self] userInfo in
        guard let self = self else { return }
        self.userImage = userInfo.profileImage
        self.profileView.configureUI(imageURL: userInfo.profileImage,
                                     userName: userInfo.name,
                                     nickName: userInfo.nickName
        )
      })
      .disposed(by: disposeBag)
  }
  
  private func buttonClicked() {
    profileView.requestFriend.rx.tap
      .subscribe(onNext: { [weak self] in
        guard let self else { return }
        guard let userImage = self.userImage else { return }
        let modalVC = AddFriendViewController(userInfo: self.userInfo,
                                              userImage: userImage,
                                              userName: profileView.userName.text ?? "")
        modalVC.modalPresentationStyle = .overFullScreen
        self.present(modalVC, animated: true)
      }).disposed(by: disposeBag)
    
    profileView.deleteFriend.rx.tap
      .subscribe(onNext: { [weak self] in
        guard let self else { return }
        
        self.navigationController?.popViewController(animated: true)
      }).disposed(by: disposeBag)
    
    profileView.requestReference.rx.tap
      .subscribe(onNext: { [weak self] in
        guard let self else { return }
        let targetId = self.userInfo
        self.navigationController?.pushViewController(RequestMyQuestionController(targetId: targetId), animated: true)
      }).disposed(by: disposeBag)
  }
}
