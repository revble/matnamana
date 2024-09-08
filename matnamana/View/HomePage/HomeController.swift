//
//  HomeController.swift
//  matnamana
//
//  Created by pc on 9/2/24.
//

import UIKit

import RxDataSources
import RxCocoa
import RxSwift



//class HomeController: UIViewController, UIScrollViewDelegate {
//  private var homeView = HomeView(frame: .zero)
//  private let disposeBag = DisposeBag()
//  
//  private lazy var dataSource = RxCollectionViewSectionedReloadDataSource<CategorySectionModel>(
//    configureCell: { dataSource, collectionView, indexPath, item in
//      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendReputationRequestCell.id, for: indexPath) as? FriendReputationRequestCell else {
//        return UICollectionViewCell()
//      }
//      // Configure your cell
//      cell.friendName.text = item.rawValue
//      return cell
//    },
//    configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
//      guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.id, for: indexPath) as? SectionHeaderView else {
//        return UICollectionReusableView()
//      }
//      header.configure(with: dataSource[indexPath.section].header)
//      return header
//    }
//  )
//  
//  override func loadView() {
//    homeView = HomeView(frame: UIScreen.main.bounds)
//    self.view = homeView
//  }
//  
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    setupCollectionView()
//    bindCollectionView()
//  }
//  
//  private func setupCollectionView() {
//    homeView.collectionView.register(FriendReputationRequestCell.self,
//                                     forCellWithReuseIdentifier: FriendReputationRequestCell.id)
//    homeView.collectionView.register(SectionHeaderView.self,
//                                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//                                     withReuseIdentifier: SectionHeaderView.id)
//  }
//  
//  private func bindCollectionView() {
//    let sections = Observable.just([
//      CategorySectionModel(header: "Section 1", items: [.friendRequest, .someOtherCategory]),
//      CategorySectionModel(header: "Section 2", items: [.friendRequest])
//    ])
//    
//    sections
//      .bind(to: homeView.collectionView.rx.items(dataSource: dataSource))
//      .disposed(by: disposeBag)
//    
//    homeView.collectionView.rx
//      .setDelegate(self)
//      .disposed(by: disposeBag)
//  }
//}
