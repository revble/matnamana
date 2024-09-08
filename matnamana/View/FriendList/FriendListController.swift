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
    super.setupView()
    friendListView = FriendListView(frame: UIScreen.main.bounds)
    self.view = friendListView
  }
  
  override func bind() {
    super.bind()
    let input = FriendListViewModel.Input(
      fetchFriends: Observable.just(()),
      searchText: friendListView.searchBar.rx.searchButtonClicked
        .withLatestFrom(friendListView.searchBar.rx.text.orEmpty)
        .filter { !$0.isEmpty }
    )
    
    let output = viewModel.transform(input: input)
    
    output.friendList
      .drive(friendListView.friendList.rx.items(
        cellIdentifier: FriendListCell.identifier,
        cellType: FriendListCell.self)
      ) { row, friend, cell in
        cell.configureCell(nickName: friend.nickname,
                           relation: friend.type.rawValue,
                           friendImage: friend.friendImage
        )}.disposed(by: disposeBag)
    
    output.searchResult
      .drive(onNext: { [weak self] userExists in
        guard let self else { return }
        guard let userNickName = self.friendListView.searchBar.text else { return }
        if userExists {
          FirebaseManager.shared.getUserInfo(nickName: userNickName) { user, error in
            if let user = user {
              let profileVC = ProfileViewController(userInfo: user.info.nickName)
              profileVC.userInfo = user.info.nickName
              self.navigationController?.pushViewController(profileVC, animated: true)
            }
          }
        }
      }).disposed(by: disposeBag)
    
    output.errorMessage
      .drive(onNext: { [weak self] message in
        guard
          let self,
          !message.isEmpty
        else { return }
        
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
      }).disposed(by: disposeBag)
  }
}
