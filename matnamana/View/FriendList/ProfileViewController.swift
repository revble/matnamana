//
//  ProfileViewController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/29/24.
//

import UIKit

import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {
  
  private var profileView = ProfileView(frame: .zero)
  private var viewModel = ProfileViewModel()
  private let disposeBag = DisposeBag()
  var userInfo: String?
  
  override func loadView() {
    profileView = ProfileView(frame: UIScreen.main.bounds)
    self.view = profileView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    bind()
    buttonClicked()
  }
  
  private func bind() {
    let input = ProfileViewModel.Input(fetchUser: Observable.just(()), nickName: userInfo ?? "")
    let output = viewModel.transform(input: input)
    
    output.userInfo
      .drive(onNext: { [weak self] userInfo in
        self?.profileView.configureUI(imageURL: userInfo.profileImage, userName: userInfo.name, nickName: userInfo.nickName)
      })
      .disposed(by: disposeBag)
  }
  
  private func buttonClicked() {
    profileView.requestFriend.rx.tap
      .subscribe(onNext: {
        let modalVC = AddFriendViewController()
        modalVC.modalPresentationStyle = .overFullScreen
        self.present(modalVC, animated: true)
      }).disposed(by: disposeBag)
    
    profileView.requestReference.rx.tap
      .subscribe(onNext: {
        print("456")
      }).disposed(by: disposeBag)
  }
}
