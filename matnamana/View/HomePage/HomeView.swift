//
//  HomeView.swift
//  matnamana
//
//  Created by pc on 9/2/24.
//

//import UIKit
//
//import SnapKit
//import Then
//
//class HomeView: UIView {
//  
//  private let homeLabel = UILabel().then {
//    $0.text = "홈"
//  }
//  
//  lazy var collectionView = UICollectionView(frame: .zero,
//                                             collectionViewLayout: createLayout())
//  override init(frame: CGRect) {
//    super.init(frame: frame)
//    configureUI()
//    setConstraint()
//  }
//  
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//
//  
//  private func configureUI() {
//    self.backgroundColor = .black
//    [
//      homeLabel,
//      collectionView
//    ].forEach { self.addSubview($0) }
//    
//    
//  }
//  
//  private func setConstraint() {
//    homeLabel.snp.makeConstraints {
//      $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(10)
//      $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).inset(10)
//    }
//    collectionView.snp.makeConstraints {
//      $0.top.equalTo(homeLabel.snp.bottom).offset(20)
//      $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide.snp.horizontalEdges)
//      $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
//    }
//  }
//  
//  
//  private func createLayout() -> UICollectionViewLayout {
//    // 아이템 크기 설정
//    let itemSize = NSCollectionLayoutSize(
//      widthDimension: .fractionalWidth(1.0),
//      heightDimension: .fractionalHeight(1.0)
//    )
//    let item = NSCollectionLayoutItem(layoutSize: itemSize)
//    
//    // 그룹 크기 설정
//    let groupSize = NSCollectionLayoutSize(
//      widthDimension: .fractionalWidth(0.25),
//      heightDimension: .fractionalHeight(0.4)
//    )
//    let group = NSCollectionLayoutGroup.horizontal(
//      layoutSize: groupSize,
//      subitems: [item]
//    )
//    
//    // 섹션 및 섹션 헤더 설정
//    let section = NSCollectionLayoutSection(group: group)
//    section.orthogonalScrollingBehavior = .continuous
//    section.interGroupSpacing = 10
//    section.contentInsets = .init(top: 10, leading: 10, bottom: 20, trailing: 10)
//    
//    let headerSize = NSCollectionLayoutSize(
//      widthDimension: .fractionalWidth(1.0),
//      heightDimension: .estimated(44)
//    )
//    let header = NSCollectionLayoutBoundarySupplementaryItem(
//      layoutSize: headerSize,
//      elementKind: UICollectionView.elementKindSectionHeader,
//      alignment: .top
//    )
//    section.boundarySupplementaryItems = [header]
//    
//    return UICollectionViewCompositionalLayout(section: section)
//  }
//}
