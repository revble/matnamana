//
//  ProfileView.swift
//  matnamana
//
//  Created by 김윤홍 on 8/29/24.
//

import UIKit

import Kingfisher
import SnapKit
import Then

final class ProfileView: UIView {
  
  private let verticalStackView: UIStackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 10
    $0.distribution = .fillEqually
  }
  
  private let horizontalStackView: UIStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 20
    $0.distribution = .fillEqually
  }
  
  let profileImage: UIImageView = UIImageView().then {
    $0.image = UIImage()
    $0.layer.cornerRadius = 100
    $0.contentMode = .scaleAspectFit
    $0.clipsToBounds = true
  }
  
  private let userName: UILabel = UILabel().then {
    $0.text = ""
    $0.textAlignment = .center
    $0.font = .boldSystemFont(ofSize: 20)
  }
  
  private let nickName: UILabel = UILabel().then {
    $0.textAlignment = .center
    $0.text = ""
    $0.font = .boldSystemFont(ofSize: 15)
  }
  
  let requestFriend: UIButton = UIButton().then {
    $0.setTitle("친구 요청", for: .normal)
    $0.backgroundColor = .manaGreen
    $0.layer.cornerRadius = 10
  }
  
  let requestReference: UIButton = UIButton().then {
    $0.setTitle("평판조회 신청", for: .normal)
    $0.backgroundColor = .manaPink
    $0.layer.cornerRadius = 10
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
    setConstraints()
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    [
      profileImage,
      verticalStackView,
      horizontalStackView
    ].forEach { self.addSubview($0) }
    
    [
      userName,
      nickName
    ].forEach { verticalStackView.addArrangedSubview($0) }
    
    [
      requestFriend,
      requestReference
    ].forEach { horizontalStackView.addArrangedSubview($0) }

  }
  
  func configureUI(imageURL: String, userName: String, nickName: String) {
    self.userName.text = userName
    self.nickName.text = nickName
    
    if let url = URL(string: imageURL) {
      profileImage.kf.setImage(with: url)
    }
  }
  
  private func setConstraints() {
    profileImage.snp.makeConstraints {
      $0.width.height.equalTo(200)
      $0.centerX.equalToSuperview()
      $0.top.equalTo(self.safeAreaLayoutGuide).inset(100)
    }
    
    verticalStackView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(profileImage.snp.bottom).offset(20)
    }
    
    horizontalStackView.snp.makeConstraints {
      $0.top.equalTo(verticalStackView.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
    }
  }
}
