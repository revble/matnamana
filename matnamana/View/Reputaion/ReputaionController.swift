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
  private var reputationView = ReputationView(frame: .zero)
  private let acceptViewModel: AcceptRequestViewModel
  private let viewModel = ReputationViewModel()
  
  init(acceptViewModel: AcceptRequestViewModel) {
    self.acceptViewModel = acceptViewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setupView() {
    super.setupView()
    reputationView = ReputationView(frame: UIScreen.main.bounds)
    self.view = reputationView
  }
  
  override func setNavigation() {
    super.setNavigation()
    self.navigationItem.title = "평판 조회"
    navigationItem.rightBarButtonItem = moveToSearchButton()
  }
  
  override func bind() {
    super.bind()
    
    let input = ReputationViewModel.Input(
      refreshGesture: reputationView.collecitonView.rx.contentOffset
    )
    
    let output = viewModel.transform(input: input)
    
    output.fetchTrigger
      .subscribe(onNext: { [weak self] in
        guard let self else { return }
        self.viewModel.fetchReputationInfo()
      }).disposed(by: disposeBag)
    
    bindCollectionView()

  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.fetchReputationInfo()
    
  }
  
  private func moveToSearchButton() -> UIBarButtonItem {
    let button = reputationView.searchFriend
    button.rx.tap
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] in
        guard let self else { return }
        //self.pushViewController(SearchViewController())
      }).disposed(by: disposeBag)
    
    return UIBarButtonItem(customView: button)
  }
  
  private func bindCollectionView() {
    let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Item>>(
      configureCell: { dataSource, collecitonView, indexPath, item in
        switch indexPath.section {
        case Section.friendRequest.rawValue:
          if item.userNickName == "" {
            guard let cell = collecitonView.dequeueReusableCell(
              withReuseIdentifier: DefaultCell.id,
              for: indexPath) as? DefaultCell else {
              return UICollectionViewCell()
            }
            cell.configure(text: "친구에 대한 질문을 기다리고 있어요! \n친구를 도와주러 가볼까요?")

            return cell
          } else {
            guard let cell = collecitonView.dequeueReusableCell(
              withReuseIdentifier: FriendRequestCell.id,
              for: indexPath) as? FriendRequestCell else {
              return UICollectionViewCell()
            }
            cell.configure(imageUrl: item.profileImageUrl, name: item.userNickName, requester: item.requesterId, target: item.targetId)
            return cell
          }
          
        case Section.myRequests.rawValue:
          if item.userNickName == "" {
            guard let cell = collecitonView.dequeueReusableCell(
              withReuseIdentifier: DefaultCell.id,
              for: indexPath) as? DefaultCell else {
              return UICollectionViewCell()
            }
            cell.configure(text: "상대에 대해 궁금한 당신! \n지금 맞나만나하러 가볼까요?")
            return cell
          } else {
            guard let cell = collecitonView.dequeueReusableCell(
              withReuseIdentifier: MyRequestsCell.id,
              for: indexPath) as? MyRequestsCell else {
              return UICollectionViewCell()
            }
            cell.configure(imageUrl: item.profileImageUrl, name: item.userNickName)
            return cell
          }
          
        case Section.receivedRequests.rawValue:
          if item.userNickName == "" {
            guard let cell = collecitonView.dequeueReusableCell(
              withReuseIdentifier: DefaultCell.id,
              for: indexPath) as? DefaultCell else {
              return UICollectionViewCell()
            }
            cell.configure(text: "맞나만나가 곧 도착할 거에요!")
            return cell
          } else {
            guard let cell = collecitonView.dequeueReusableCell(
              withReuseIdentifier: ReceivedRequestCell.id,
              for: indexPath) as? ReceivedRequestCell else {
              return UICollectionViewCell()
            }
            cell.configure(imageUrl: item.profileImageUrl, name: item.userNickName)
            return cell
          }
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
    
    reputationView.collecitonView.rx.itemSelected
      .subscribe(onNext: { [weak self] indexPath in
        guard let self else { return }
        switch indexPath.section {
        case Section.friendRequest.rawValue:
          print("friendRequest: \(indexPath.row)")
          if let cell =
              self.reputationView.collecitonView.cellForItem(at: indexPath) as? FriendRequestCell {
            let nickName = cell.nameLabel.text ?? ""
            let requesterId = cell.requesterId
            let targetId = cell.targetId
            pushViewController(ReplyController(name: nickName, requester: requesterId, target: targetId))
          }
          
          
        case Section.myRequests.rawValue:
          print("myRequests: \(indexPath.row)")
          
        case Section.receivedRequests.rawValue:
          print("receivedRequests: \(indexPath.row)")
          
          self.presentModally(UINavigationController(rootViewController: AcceptRequestController(viewModel: acceptViewModel)))
          if let cell = self.reputationView.collecitonView.cellForItem(at: indexPath) as? ReceivedRequestCell {
            if let name = cell.name {
              self.acceptViewModel.selectName(name)
            }
          }
          
        default:
          break
        }
      })
      .disposed(by: disposeBag)
    
    Observable.combineLatest(
      viewModel.friendReputationDataRelay,
      viewModel.myRequestedReputationDataRelay,
      viewModel.receivedReputationDataRelay
    )
      .observe(on: MainScheduler.instance)
      .map { (friendData, myRequestedData, receivedData) -> [SectionModel<String, Item>] in
        let friendReputationItems = friendData.isEmpty 
        ? [Item(userNickName: "", profileImageUrl: "", requesterId: "", targetId: "")]
        : friendData.map { (profileImage, userNickName, requesterId , targetId) in
          Item(userNickName: userNickName, profileImageUrl: profileImage, requesterId: requesterId, targetId: targetId)
        }
        let myRequestedItems = myRequestedData.isEmpty
        ? [Item(userNickName: "", profileImageUrl: "", requesterId: "", targetId: "")]
        : myRequestedData.map { (profileImage, userNickName) in
          Item(userNickName: userNickName, profileImageUrl: profileImage, requesterId: "", targetId: "")
        }
        let receivedRequestItems = receivedData.isEmpty
        ? [Item(userNickName: "", profileImageUrl: "", requesterId: "", targetId: "")]
        : receivedData.map { (profileImage, userNickName) in
          Item(userNickName: userNickName, profileImageUrl: profileImage, requesterId: "", targetId: "")
        }

        return [
          SectionModel(model: Section.friendRequest.title,
                       items: friendReputationItems),
          SectionModel(model: Section.myRequests.title,
                       items: myRequestedItems),
          SectionModel(model: Section.receivedRequests.title,
                       items: receivedRequestItems)
        ]
      }
      .bind(to: reputationView.collecitonView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }
}
