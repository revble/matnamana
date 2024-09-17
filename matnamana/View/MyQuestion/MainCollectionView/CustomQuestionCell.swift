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
  
  let customQuestionLabel = UILabel().then {
    $0.text = ""
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
    self.addSubview(customQuestionLabel)
  }
  
  private func setConstraints() {
    
    customQuestionLabel.snp.makeConstraints {
      $0.horizontalEdges.equalToSuperview().inset(16)
      $0.height.equalTo(56)
    }
  }
  
  func configure(title: String) {
    customQuestionLabel.text = title
  }
}
