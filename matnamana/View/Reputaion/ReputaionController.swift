//
//  ReputaionController.swift
//  matnamana
//
//  Created by pc on 9/6/24.
//

import UIKit

import RxCocoa
import RxDataSources
import RxSwift
import SnapKit
import Then

final class ReputaionController: BaseViewController {
  private var reputaionView = ReputationView(frame: .zero)
  
  override func setupView() {
    super.setupView()
    reputaionView = ReputationView(frame: UIScreen.main.bounds)
    self.view = reputaionView
  }
  
  override func setNavigation() {
    super.setNavigation()
    self.navigationItem.title = "평판 조회"
    
    navigationItem.rightBarButtonItem = moveToSearchButton()
  }
  
  override func bind() {
    super.bind()
    bindCollectionView()
  }
  
  private func moveToSearchButton() -> UIBarButtonItem {
    let button = reputaionView.searchFriend
    
    button.rx.tap
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        self.pushViewController(SearchViewController())
      }).disposed(by: disposeBag)
    
    return UIBarButtonItem(customView: button)
  }
  
  private func bindCollectionView() {
    let sections = Observable.just([
      SectionModel(model: Section.friendRequest.title,
                   items: Array(repeating: Item(id: 0, title: "Friend Request"), count: 5)),
      SectionModel(model: Section.myRequests.title,
                   items: Array(repeating: Item(id: 0, title: "My Requests"), count: 5)),
      SectionModel(model: Section.receivedRequests.title,
                   items: Array(repeating: Item(id: 0, title: "Received Requests"), count: 5))
    ])
    
    let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Item>>(
      configureCell: { dataSource, collecitonView, indexPath, item in
        switch indexPath.section {
        case Section.friendRequest.rawValue:
          guard let cell = collecitonView.dequeueReusableCell(
            withReuseIdentifier: FriendRequestCell.id,
            for: indexPath) as? FriendRequestCell else {
            return UICollectionViewCell()
          }
          return cell
        case Section.myRequests.rawValue:
          guard let cell = collecitonView.dequeueReusableCell(
            withReuseIdentifier: MyRequestsCell.id,
            for: indexPath) as? MyRequestsCell else {
            return UICollectionViewCell()
          }
          return cell
        case Section.receivedRequests.rawValue:
          guard let cell = collecitonView.dequeueReusableCell(
            withReuseIdentifier: ReceivedRequestCell.id,
            for: indexPath) as? ReceivedRequestCell else {
            return UICollectionViewCell()
          }
          return cell
        default:
          return UICollectionViewCell()
        }
      },
      configureSupplementaryView: { dataSource, collecitonView, kind, indexPath in
        guard kind == UICollectionView.elementKindSectionHeader else {
          return UICollectionReusableView()
        }
        guard let headerView = collecitonView.dequeueReusableSupplementaryView(
          ofKind: kind,
          withReuseIdentifier: ReputaionSectionHeaderView.id,
          for: indexPath) as? ReputaionSectionHeaderView else {
          return UICollectionReusableView()
        }
        let sectionTitle = dataSource[indexPath.section].model
        headerView.configure(with: sectionTitle)
        return headerView
      }
    )
    
    sections
      .bind(to: reputaionView.collecitonView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }
}
