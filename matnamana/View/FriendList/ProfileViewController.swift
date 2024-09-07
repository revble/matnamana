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
    profileView = ProfileView(frame: UIScreen.main.bounds)
    self.view = profileView
  }

  override func bind() {
    buttonClicked()
    let input = UserProfileViewModel.Input(fetchUser: Observable.just(()), nickName: userInfo)
    let output = viewModel.transform(input: input)
    
    output.userInfo
      .drive(onNext: { [weak self] userInfo in
        guard let self = self else { return }
        self.userImage = userInfo.profileImage
        self.profileView.configureUI(imageURL: userInfo.profileImage, userName: userInfo.name, nickName: userInfo.nickName)
      })
      .disposed(by: disposeBag)
  }
  
  private func buttonClicked() {
    profileView.requestFriend.rx.tap
      .subscribe(onNext: {
        guard let userImage = self.userImage else { return }
        let modalVC = AddFriendViewController(userInfo: self.userInfo, userImage: userImage)
        modalVC.modalPresentationStyle = .overFullScreen
        self.present(modalVC, animated: true)
      }).disposed(by: disposeBag)
    
    profileView.requestReference.rx.tap
      .subscribe(onNext: {
        self.navigationController?.pushViewController(ReferenceCheckController(targetId: self.userInfo), animated: true)
      }).disposed(by: disposeBag)
  }
}
