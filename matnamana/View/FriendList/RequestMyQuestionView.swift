//
//  RequestMyQuestionView.swift
//  matnamana
//
//  Created by 김윤홍 on 9/20/24.
//

import UIKit

import SnapKit
import Then

final class RequestMyQuestionView: BaseView {
  
  private let beacon = UIImageView().then {
    let beacon = UIImage(systemName: "light.beacon.min")
    $0.image = beacon
    $0.tintColor = .beaconColor
  }
  
  private let textView = UITextView().then {
    $0.textColor = .beaconColor
    $0.text = "작성하신 질문지는 상대방 친구에게만 전달됩니다 질문지를 선택한 이후 상대방에게 맞나만나 승인이 요청됩니다."
    $0.font = .systemFont(ofSize: 17, weight: .semibold)
    $0.isScrollEnabled = false
    $0.isEditable = false
  }
  
  let myPresetQuestion: UICollectionView = {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
      
      // 아이템과 그룹 설정
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
      let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
      
      let section = NSCollectionLayoutSection(group: group)
      section.interGroupSpacing = 10
      return section
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    return collectionView
  }()
  
  override func configureUI() {
    super.configureUI()
    [
      beacon,
      textView,
      myPresetQuestion
    ].forEach { self.addSubview($0) }
  }
  
  override func setConstraints() {
    super.setConstraints()
    
    beacon.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
      $0.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
      $0.width.height.equalTo(30)
    }
    
    textView.snp.makeConstraints {
      $0.top.equalTo(beacon.snp.bottom).offset(8)
      $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
      $0.height.equalTo(100)
    }
    
    myPresetQuestion.snp.makeConstraints {
      $0.top.equalTo(textView.snp.bottom).offset(24)
      $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
      $0.height.equalTo(self.safeAreaLayoutGuide)
    }
  }
  
  func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
      
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
      let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
      
      let section = NSCollectionLayoutSection(group: group)
      section.interGroupSpacing = 10
      
      return section
    }
  }
}
