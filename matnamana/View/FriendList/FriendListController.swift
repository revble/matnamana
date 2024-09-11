//
//  FriendListController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/23/24.

import UIKit

import RxCocoa
import RxDataSources
import RxSwift

final class FriendListController: BaseViewController {
  
  private let viewModel = FriendListViewModel()
  private var friendListView = FriendListView(frame: .zero)
  
  override func setupView() {
    super.setupView()
    friendListView = FriendListView(frame: UIScreen.main.bounds)
    self.view = friendListView
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.fetchFriends()
  }
  
  override func bind() {
    super.bind()
    let acceptTapSubject = PublishSubject<User.Friend>()
    let input = FriendListViewModel.Input(
      fetchFriends: Observable.just(()),
      searchText: friendListView.searchBar.rx.searchButtonClicked
        .withLatestFrom(friendListView.searchBar.rx.text.orEmpty)
        .filter { !$0.isEmpty },
      acceptTap: acceptTapSubject.asObservable()
    )
    
    let output = viewModel.transform(input: input)
    
    let dataSource = RxTableViewSectionedReloadDataSource<FriendsSection>(
      configureCell: { dataSource, tableView, indexPath, friend in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FriendListCell.self), for: indexPath) as? FriendListCell else { return UITableViewCell() }
        let friend = dataSource[indexPath]
        cell.configureCell(nickName: friend.friendId,
                           relation: friend.type.rawValue,
                           friendImage: friend.friendImage)
        
        if dataSource[indexPath.section].header == "내가 보낸 요청" {
          cell.acceptButton.isHidden = true
          cell.refuseButton.isHidden = true
          cell.userName.isHidden = true
          cell.userRelation.isHidden = true
          cell.sendRequestLabel.isHidden = false
          cell.backgroundColor = UIColor(red: 239/255, green: 248/255, blue: 225/255, alpha: 1)
          cell.updateRequestLabel(name: friend.name)
        } else if dataSource[indexPath.section].header == "친구수락 대기중" {
          cell.acceptButton.isHidden = false
          cell.refuseButton.isHidden = false
          cell.sendRequestLabel.isHidden = true
          cell.acceptButton.rx.tap
            .map { friend }
            .bind(to: acceptTapSubject)
            .disposed(by: self.disposeBag)
        } else {
          cell.acceptButton.isHidden = true
          cell.refuseButton.isHidden = true
          cell.sendRequestLabel.isHidden = false
        }
        return cell
      },
      titleForHeaderInSection: { dataSource, index in
        return dataSource[index].header
      }
    )
    
    output.friendList
      .drive(friendListView.friendList.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
    
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
        guard let self else { return }
        guard !message.isEmpty else { return }
        
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
      })
      .disposed(by: disposeBag)
  }
}
