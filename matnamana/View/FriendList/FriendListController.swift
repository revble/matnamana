//
//  FriendListController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/23/24.

import UIKit

import RxSwift

final class FriendListController: BaseViewController {
  
  private let viewModel = FriendListViewModel()
  private var friendListView = FriendListView(frame: .zero)
  
  override func setupView() {
    friendListView = FriendListView(frame: UIScreen.main.bounds)
    self.view = friendListView
  }
  
  override func setNavigation() {
    navigationItem.rightBarButtonItem = plusButton()
  }
  
  private func plusButton() -> UIBarButtonItem {
    let button = friendListView.addFriend
    
    button.rx.tap
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        self.navigationController?.pushViewController(SearchViewController(), animated: true)
        
      }).disposed(by: disposeBag)
    
    return UIBarButtonItem(customView: button)
  }
  
  override func bind() {
    let input = FriendListViewModel.Input(fetchFriends: Observable.just(()))
    let output = viewModel.transform(input: input)
    
    output.friendList
      .drive(friendListView.friendList.rx
        .items(cellIdentifier: FriendListCell.identifier,
               cellType: FriendListCell.self)) { row, friend, cell in
        cell.configureCell(nickName: friend.nickname,
                           relation: friend.type.rawValue,
                           friendImage: friend.friendImage)
      }.disposed(by: disposeBag)
  }
}

