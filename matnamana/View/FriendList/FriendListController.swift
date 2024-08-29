//
//  FriendListController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/23/24.
//

import UIKit

import RxCocoa
import RxSwift

class FriendListController: UIViewController {
  
  private var friendListView = FriendListView(frame: .zero)
  private let disposeBag = DisposeBag()
  private let viewModel = FriendListViewModel()
  
  override func loadView() {
    friendListView = FriendListView(frame: UIScreen.main.bounds)
    self.view = friendListView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    friendListView.friendList.register(FriendListCell.self,
                                       forCellReuseIdentifier: FriendListCell.identifier)
    bind()
    
    friendListView.addFriend.rx.tap
      .subscribe(onNext: {
        self.navigationController?.pushViewController(SearchViewController(), animated: true)
      }).disposed(by: disposeBag)
  }
  
  func bind() {
    let input = FriendListViewModel.Input(fetchFriends: Observable.just(()))
    let output = viewModel.transform(input: input)
    
    output.friendList
      .drive(friendListView.friendList.rx.items(cellIdentifier: FriendListCell.identifier, cellType: FriendListCell.self)) { row, friend, cell in
        cell.configureCell(nickName: friend.nickname, relation: friend.type.rawValue)

      }.disposed(by: disposeBag)
  }
}
