//
//  AddFriendViewController.swift
//  matnamana
//
//  Created by 김윤홍 on 9/1/24.
//

import UIKit

import RxCocoa
import RxSwift

final class AddFriendViewController: BaseViewController {
  
  private var addFriendView = AddFriendView(frame: .zero)
  private var friendType = ""
  private let viewModel = addFriendViewModel()
  var userInfo: String
  var userImage: String
  
  init(userInfo: String, userImage: String) {
    self.userInfo = userInfo
    self.userImage = userImage
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setupView() {
    addFriendView = AddFriendView(frame: UIScreen.main.bounds)
    self.view = addFriendView
  }
  
  override func bind() {
    addFriendView.closeButton.rx.tap
      .subscribe(onNext: {
        self.dismiss(animated: true, completion: nil)
      }).disposed(by: disposeBag)
    
    addFriendView.familyButton.rx.tap
      .subscribe(onNext: {
        self.friendType = "family"
      }).disposed(by: disposeBag)
    
    addFriendView.friendButton.rx.tap
      .subscribe(onNext: {
        self.friendType = "friend"
      }).disposed(by: disposeBag)
    
    addFriendView.colleagueButton.rx.tap
      .subscribe(onNext: {
        self.friendType = "colleague"
      }).disposed(by: disposeBag)
    
    addFriendView.sendButton.rx.tap
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        let friendId = userInfo
        let friendType = self.friendType
        let input = addFriendViewModel.Input(addFriend: .just([friendId, self.friendType, userImage]))
        let output = self.viewModel.transform(input: input)
        
        output.addFriendResult
          .drive(onNext: { success in
            if success {
              print("성공")
            } else {
              print("실패")
            }
            self.dismiss(animated: true, completion: nil)
          }).disposed(by: self.disposeBag)
      }).disposed(by: disposeBag)
  }
}
