//
//  ReceivedRequestCollectionViewCell.swift
//  matnamana
//
//  Created by pc on 9/6/24.
//
import UIKit

import Kingfisher
import SnapKit
import Then

final class ReceivedRequestCell: UICollectionViewCell {
  ///String(describing: )
  static let id = "ReceivedRequestViewCell"
  
  private let imageView = UIImageView().then {
    $0.image = UIImage()
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 40
  }
  
  private let nameLabel = UILabel().then {
    $0.text = "이지은 -> 박동현"
    $0.textAlignment = .center
    $0.font = .boldSystemFont(ofSize: 18)
  }
  
  private let statusLabel = UILabel().then {
    $0.text = "평판조회를 요청받았습니다."
    $0.textAlignment = .center
    $0.font = .systemFont(ofSize: 16)
  }
  
  private let acceptButton = UIButton().then {
    $0.setTitle("수락하기", for: .normal)
  }
  private let cancelButton = UIButton().then {
    $0.setTitle("무시하기", for: .normal)
  }
  
  private let buttonStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 10
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    self.layer.cornerRadius = 10
    self.layer.borderWidth = 1
    self.layer.borderColor = UIColor.black.cgColor
    [
      acceptButton,
      cancelButton
    ].forEach { buttonStackView.addArrangedSubview($0) }
    
    [
      imageView,
      nameLabel,
      statusLabel,
      buttonStackView
    ].forEach { self.addSubview($0) }
    
    imageView.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(6)
      $0.left.equalToSuperview().offset(10)
      $0.width.height.equalTo(80)
    }
    
    nameLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().offset(6)
    }
    
    statusLabel.snp.makeConstraints {
      $0.centerY.equalTo(imageView.snp.centerY)
      $0.left.equalTo(imageView.snp.right).offset(20)
    }
    
    buttonStackView.snp.makeConstraints {
      $0.top.equalTo(statusLabel.snp.bottom).offset(2)
      $0.centerX.equalTo(statusLabel.snp.centerX)
    }
  }
  
  func configure(imageUrl: String, name: String) {
    if let url = URL(string: imageUrl) {
      imageView.kf.setImage(with: url)
    }
    nameLabel.text = "\(name) -> 나"
  }
}
