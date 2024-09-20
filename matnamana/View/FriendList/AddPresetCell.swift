//
//  AddPresetCell.swift
//  matnamana
//
//  Created by 김윤홍 on 9/20/24.
//

import UIKit

import SnapKit
import Then

final class AddPresetCell: UICollectionViewCell {
  
  private let titleLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 17, weight: .semibold)
    $0.textColor = .manaMainColor
    $0.textAlignment = .center
    $0.numberOfLines = 0
    $0.text = "내 질문 추가하기"
  }
  
  private let imageView = UIImageView().then {
    $0.image = UIImage(systemName: "plus")
  }
  
  private let stackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 5
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
    contentView.backgroundColor = .white
    contentView.layer.cornerRadius = 16
    contentView.clipsToBounds = true
    contentView.layer.borderWidth = 1
    contentView.layer.borderColor = UIColor.manaMainColor.cgColor
    [titleLabel, imageView].forEach { stackView.addArrangedSubview($0) }
    contentView.addSubview(stackView)
    
  }
  
  private func setConstraints() {
    
    stackView.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
}

