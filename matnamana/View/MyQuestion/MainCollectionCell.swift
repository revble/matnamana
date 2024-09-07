//
//  MainCollectionCell.swift
//  matnamana
//
//  Created by 김윤홍 on 9/7/24.
//

import UIKit

import SnapKit
import Then

class MainCollectionCell: UICollectionViewCell {
  static let identifier = "CustomCell"
  
  let titleLabel = UILabel().then {
    $0.textColor = .black
    $0.font = .systemFont(ofSize: 16)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    setConstraints()
    self.contentView.layer.cornerRadius = 10
    self.contentView.layer.masksToBounds = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    contentView.addSubview(titleLabel)
  }
  
  private func setConstraints() {
    titleLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
}
