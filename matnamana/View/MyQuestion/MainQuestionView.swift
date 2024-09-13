//
//  MainQuestionView.swift
//  matnamana
//
//  Created by 김윤홍 on 9/7/24.
//

import UIKit

import SnapKit
import Then

final class MainQuestionView: BaseView {
  
  //  let totalListButton = UIButton().then {
  //    $0.backgroundColor = .manaGreen
  //    $0.setTitle("전체 질문 페이지", for: .normal)
  //    $0.setTitleColor(.white, for: .normal)
  //    $0.layer.cornerRadius = 8
  //  }
  
  let mainCollection: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
    $0.register(BannerCell.self, forCellWithReuseIdentifier: String(describing: BannerCell.self))
    $0.register(QuestionCell.self, forCellWithReuseIdentifier: String(describing: QuestionCell.self))
    $0.register(CustomQuestionCell.self, forCellWithReuseIdentifier: String(describing: CustomQuestionCell.self))
    $0.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: HeaderView.self))
  }
  
  override func configureUI() {
    super.configureUI()
    [
      mainCollection
    ].forEach { self.addSubview($0) }
  }
  
  override func setConstraints() {
    super.setConstraints()
    mainCollection.snp.makeConstraints {
      $0.edges.equalTo(self.safeAreaLayoutGuide)
    }
  }
  
  private static func createLayout() -> UICollectionViewLayout {
    return UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
      switch sectionIndex {
      case 0:
        return self.createFirstSection()
      case 1:
        return self.createSecondSection()
      case 2:
        return self.createThirdSectionWithHeader()
      default:
        return nil
      }
    }
  }
  
  private static func createFirstSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .groupPaging
    return section
  }
  
  // 두 번째 섹션 레이아웃
  private static func createSecondSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    return section
  }
  
  // 세 번째 섹션 레이아웃 (헤더 포함)
  private static func createThirdSectionWithHeader() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    
    // 헤더 추가
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    section.boundarySupplementaryItems = [header]
    
    return section
  }
}
