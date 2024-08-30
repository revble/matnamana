//
//  FriendListController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/23/24.
//이거 보기

import UIKit

class FriendListController: UIViewController {
}
//  override func viewDidLoad() {
//    super.viewDidLoad()
//<<<<<<< Updated upstream
//=======
//    friendListView.friendList.register(FriendListCell.self,
//                                       forCellReuseIdentifier: FriendListCell.identifier)
//    bind()
//    
//    friendListView.addFriend.rx.tap
//      .subscribe(onNext: {
//        self.navigationController?.pushViewController(SearchViewController(), animated: true)
//      }).disposed(by: disposeBag)
//  }
//  
//  func bind() {
//    let input = FriendListViewModel.Input(fetchFriends: Observable.just(()))
//    let output = viewModel.transform(input: input)
//    
//    output.friendList//테이블뷰 rxcocoa로 등록 코드
//      .drive(friendListView.friendList.rx.items(cellIdentifier: FriendListCell.identifier, cellType: FriendListCell.self)) { row, friend, cell in
//        cell.configureCell(nickName: friend.nickname, relation: friend.type.rawValue)
//
//      }.disposed(by: disposeBag)
//>>>>>>> Stashed changes
//  }
//}
