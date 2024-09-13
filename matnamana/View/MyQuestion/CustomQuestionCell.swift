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
  private let customQuestionLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 16)
    $0.numberOfLines = 0
    $0.textColor = .black
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    contentView.addSubview(customQuestionLabel)
    customQuestionLabel.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(10)
    }
  }
  
  func configure(with text: String) {
    customQuestionLabel.text = text
  }
}
