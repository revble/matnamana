//
//  FriendRequestCollectionViewCell.swift
//  matnamana
//
//  Created by pc on 9/6/24.
//

import UIKit

import SnapKit
import Then

final class FriendRequestCell: UICollectionViewCell {
  ///String(describing: )
  static let id = "FriendRequestCell"
  
  private let imageView = UIImageView().then {
    $0.image = UIImage(named: "profile")
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    $0.backgroundColor = .white
    $0.layer.cornerRadius = 40
  }
  
  private let nameLabel = UILabel().then {
    $0.text = "이지은"
    $0.textAlignment = .center
    $0.font = .boldSystemFont(ofSize: 18)
  }
  
  private let reputaionLabel = UILabel().then {
    $0.text = "평판조회요청"
    $0.textAlignment = .center
    $0.font = .systemFont(ofSize: 16)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    self.backgroundColor = .manaSkin
    self.layer.cornerRadius = 10
    self.layer.masksToBounds = false
    self.layer.shadowOpacity = 0.8
    self.layer.shadowOffset = CGSize(width: -2, height: 2)
    self.layer.shadowRadius = 10
    [
      imageView,
      nameLabel,
      reputaionLabel
    ].forEach { self.addSubview($0) }
    
    imageView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(20)
      $0.centerX.equalToSuperview()
      $0.width.height.equalTo(80)
    }
    
    nameLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(imageView.snp.bottom).offset(6)
    }
    
    reputaionLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(nameLabel.snp.bottom).offset(3)
    }
  }
  
  func configure(systemImage: String) {
    imageView.image = UIImage(systemName: systemImage)
  }
}
