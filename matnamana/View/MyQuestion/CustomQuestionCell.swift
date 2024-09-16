//
//  CustomQuestionCell.swift
//  matnamana
//
//  Created by 김윤홍 on 9/12/24.
//

import UIKit

import SnapKit
import Then

final class CustomQuestionCell: UICollectionViewCell {
  
  let customQuestionButton = UIButton().then {
    $0.backgroundColor = .manaMainColor
    $0.setTitle("아이스 브레이킹 질문", for: .normal)
    $0.layer.cornerRadius = 16
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    self.addSubview(customQuestionButton)
  }
  
  private func setConstraints() {
    
    customQuestionButton.snp.makeConstraints {
      $0.horizontalEdges.equalToSuperview().inset(16)
      $0.height.equalTo(56)
    }
  }
}
