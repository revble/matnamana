//
//  FriendListController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/23/24.
//

import UIKit

import RxCocoa
import RxSwift

final class FriendListController: UIViewController {
  
  private var friendListView = FriendListView(frame: .zero)
  private let disposeBag = DisposeBag()
  private let viewModel = FriendListViewModel()
  
  override func loadView() {
    friendListView = FriendListView(frame: UIScreen.main.bounds)
    self.view = friendListView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigation()
    bind()
  }
  
  private func setNavigation() {
    self.title = "친구 목록"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.largeTitleDisplayMode = .always
    navigationItem.rightBarButtonItem = plusButton()
  }
  
  private func plusButton() -> UIBarButtonItem {
    let button = friendListView.addFriend
    
    button.rx.tap
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        DispatchQueue.main.async {
          self.navigationController?.pushViewController(SearchViewController(), animated: true)
        }
      }).disposed(by: disposeBag)
    
    return UIBarButtonItem(customView: button)
  }
  
  private func bind() {
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
