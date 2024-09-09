//
//  aceptRequestController.swift
//  matnamana
//
//  Created by pc on 9/9/24.
//

import UIKit
import RxSwift

class AcceptRequestController: FriendListController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    friendListView.friendList.allowsMultipleSelection = true
    self.navigationItem.rightBarButtonItem = sendButton()
  }
  
  override func bind() {
    super.bind()
  }
  
  private func sendButton() -> UIBarButtonItem {
    let button = UIButton(type: .system)
    button.setTitle("보내기", for: .normal)
    
    button.rx.tap
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] in
        guard let self else { return }
        
      }).disposed(by: disposeBag)
    
    return UIBarButtonItem(customView: button)
  }
}
