//
//  RequestMyQuestionCell.swift
//  matnamana
//
//  Created by 김윤홍 on 9/20/24.
//
import UIKit

import SnapKit
import Then

final class RequestMyQuestionCell: UICollectionViewCell {
  
  private let titleLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 17, weight: .semibold)
    $0.textColor = .white
    $0.textAlignment = .center
    $0.numberOfLines = 0
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
    contentView.backgroundColor = .manaMainColor
    contentView.layer.cornerRadius = 16
    contentView.clipsToBounds = true
    contentView.addSubview(titleLabel)
  }
  
  private func setConstraints() {
    
    titleLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
  
  func configure(title: String) {
    titleLabel.text = title
  }
}
