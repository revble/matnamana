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
  private let viewModel = ReputaionViewModel()
  
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
    refreshingGesture()
  }
  
  private func moveToSearchButton() -> UIBarButtonItem {
    let button = reputaionView.searchFriend
    
    button.rx.tap
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        //self.pushViewController(SearchViewController())
      }).disposed(by: disposeBag)
    
    return UIBarButtonItem(customView: button)
  }
  
  private func refreshingGesture() {
    reputaionView.collecitonView.rx.contentOffset
      .subscribe(onNext: { [weak self] contentOffset in
        guard let self else { return }
        let deafaultOffset = self.reputaionView.collecitonView.contentOffset.y
        if deafaultOffset < -100 {
          viewModel.fetchRequestedReputation()
        }
        print(deafaultOffset)
      }).disposed(by: disposeBag)
  }
  
  private func bindCollectionView() {
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
          cell.configure(imageUrl: item.profileImageUrl, name: item.userNickName)
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
    viewModel.reputationDataRelay
      .observe(on: MainScheduler.instance)
      .map { data -> [SectionModel<String, Item>] in
        let receivedRequestItems = data.map { (profileImage, userNickName) in
          Item(userNickName: userNickName, profileImageUrl: profileImage)
        }
        return [
          SectionModel(model: Section.friendRequest.title,
                       items: Array(repeating: Item(userNickName: "", profileImageUrl: ""), count: 5)),
          SectionModel(model: Section.myRequests.title,
                       items: Array(repeating: Item(userNickName: "", profileImageUrl: ""), count: 5)),
          SectionModel(model: Section.receivedRequests.title,
                       items: receivedRequestItems)
        ]
      }
      .bind(to: reputaionView.collecitonView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }
}
