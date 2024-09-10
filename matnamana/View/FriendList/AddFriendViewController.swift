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
  private var status = ""
  private let viewModel = AddFriendViewModel()
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
    super.setupView()
    addFriendView = AddFriendView(frame: UIScreen.main.bounds)
    self.view = addFriendView
  }
  
  override func bind() {
    super.bind()
    addFriendView.closeButton.rx.tap
      .subscribe(onNext: { [weak self] in
        guard let self else { return }
        self.dismiss(animated: true, completion: nil)
      }).disposed(by: disposeBag)
    
    addFriendView.familyButton.rx.tap
      .subscribe(onNext: { [weak self] in
        guard let self else { return }
        self.friendType = "family"
        self.status = "pending"
        addFriendView.familyButton.backgroundColor = .green
        addFriendView.friendButton.backgroundColor = .manaPink
        addFriendView.colleagueButton.backgroundColor = .manaMint
      }).disposed(by: disposeBag)
    
    addFriendView.friendButton.rx.tap
      .subscribe(onNext: { [weak self] in
        guard let self else { return }
        self.friendType = "friend"
        self.status = "pending"
        addFriendView.familyButton.backgroundColor = .manaGreen
        addFriendView.friendButton.backgroundColor = .systemPink
        addFriendView.colleagueButton.backgroundColor = .manaMint
      }).disposed(by: disposeBag)
    
    addFriendView.colleagueButton.rx.tap
      .subscribe(onNext: { [weak self] in
        guard let self else { return }
        self.friendType = "colleague"
        self.status = "pending"
        addFriendView.familyButton.backgroundColor = .manaGreen
        addFriendView.friendButton.backgroundColor = .manaPink
        addFriendView.colleagueButton.backgroundColor = .systemMint
      }).disposed(by: disposeBag)
    
    addFriendView.sendButton.rx.tap
      .subscribe(onNext: { [weak self] in
        guard let self else { return }
        let input = AddFriendViewModel.Input(addFriend: .just([userInfo, self.friendType, userImage, self.status]))
        let output = self.viewModel.transform(input: input)
        
        output.addFriendResult
          .drive(onNext: { [weak self] success in
            guard let self else { return }
            if success {
              print("성공")
            } else {
              print("실패")
            }
            let alertController = UIAlertController(title: "친구 신청 완료",
                                                    message: "친구 신청이 완료되었습니다.",
                                                    preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
              guard let self else { return }
              self.navigationController?.popViewController(animated: true)
            }
            alertController.addAction(confirmAction)
            
            // dismiss 완료 후 알림 표시
            self.dismiss(animated: true, completion: { [weak self] in
              self?.present(alertController, animated: true, completion: nil)
            })
            
          }).disposed(by: self.disposeBag)
      }).disposed(by: disposeBag)
  }
}
