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
  
  let totalListButton = UIButton().then {
    $0.backgroundColor = .manaGreen
    $0.setTitle("전체 질문 페이지", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.layer.cornerRadius = 8
  }
  
  let questionCollection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumInteritemSpacing = 10
    layout.minimumLineSpacing = 20
    let screenWidth = UIScreen.main.bounds.width
    layout.itemSize = CGSize(width: (screenWidth - 70) / 2, height: 150)
    $0.collectionViewLayout = layout
    $0.backgroundColor = .white
    $0.register(MainCollectionCell.self, forCellWithReuseIdentifier: MainCollectionCell.identifier)
  }
  
  override func configureUI() {
    [
      totalListButton,
      questionCollection
    ].forEach { self.addSubview($0) }
    
  }
  
  override func setConstraints() {
    totalListButton.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
      $0.horizontalEdges.equalToSuperview().inset(20)
      $0.height.equalTo(100)
    }
    
    questionCollection.snp.makeConstraints {
      $0.top.equalTo(totalListButton.snp.bottom).offset(20)
      $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
    }
  }
}
