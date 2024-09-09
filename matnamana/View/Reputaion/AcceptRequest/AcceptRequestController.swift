//
//  aceptRequestController.swift
//  matnamana
//
//  Created by pc on 9/9/24.
//

import UIKit
import RxSwift

class AcceptRequestController: FriendListController {
  private let viewModel = AcceptRequestViewModel()
  override func viewDidLoad() {
    super.viewDidLoad()
    friendListView.friendList.allowsMultipleSelection = true
    self.navigationItem.rightBarButtonItem = sendButton()
  }
  
  override func bind() {
    super.bind()
    
    friendListView.friendList.rx.itemSelected
      .subscribe(onNext: { [weak self] indexPath in
        guard let self = self else { return }
        self.viewModel.selectItem(at: indexPath)
      }).disposed(by: disposeBag)
    
    friendListView.friendList.rx.itemDeselected
      .subscribe(onNext: { [weak self] indexPath in
        guard let self = self else { return }
        self.viewModel.removeItem(at: indexPath)
      }).disposed(by: disposeBag)
    
    viewModel.selectedItems
      .asDriver()
      .drive(onNext: { [weak self] selectedItems in
        guard let self = self else { return }
        let allIndexPaths = self.friendListView.friendList.indexPathsForSelectedRows ?? []
        if selectedItems.count > 2 {
          self.viewModel.removeFirstItem()
        }
        allIndexPaths.forEach { indexPath in
          if !selectedItems.contains(indexPath) {
            self.friendListView.friendList.deselectRow(at: indexPath, animated: true)
          }
        }
        print("현재 선택된 항목들: \(selectedItems)")
      }).disposed(by: disposeBag)
  }
  
  private func sendButton() -> UIBarButtonItem {
    let button = UIButton(type: .system)
    button.setTitle("보내기", for: .normal)
    
    button.rx.tap
      .asDriver()
      .drive(onNext: { [weak self] in
        guard let self else { return }
        // 친구 보내기
        dismiss(animated: true)
      }).disposed(by: disposeBag)
    
    return UIBarButtonItem(customView: button)
  }
  
}
