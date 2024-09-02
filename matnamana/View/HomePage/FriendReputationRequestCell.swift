//
//  Friend.swift
//  matnamana
//
//  Created by pc on 9/2/24.
//

import UIKit

import SnapKit
import Then

class FriendReputationRequestCell: UICollectionViewCell {
  static let id = "FriendReputationRequestCell"
  
  private let friendImage = UIImageView().then {
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    $0.backgroundColor = .darkGray
    $0.layer.cornerRadius = 10
  }
  
  let friendName = UILabel().then {
    $0.text = "이지은"
  }
  
  private let requestReputation = UILabel().then {
    $0.text = "평판조회요청"
  }
  
  private let cellStackView = UIStackView().then {
    $0.axis = .vertical
    $0.distribution = .equalSpacing
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    setConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    friendImage.frame = contentView.bounds
    [
      friendImage,
      friendName,
      requestReputation
    ].forEach { cellStackView.addArrangedSubview($0) }
    
    self.addSubview(cellStackView)
  }
  
  private func setConstraint() {
    friendImage.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
    }
    
  }
}


