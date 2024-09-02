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

class ProfileView: UIView {
  
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
  
  private let profileImage: UIImageView = UIImageView().then {
    $0.image = UIImage()
    $0.layer.cornerRadius = 50
    $0.contentMode = .scaleAspectFit
    $0.clipsToBounds = true
  }
  
  private let userName: UILabel = UILabel().then {
    $0.text = ""
    $0.font = .boldSystemFont(ofSize: 20)
  }
  
  private let nickName: UILabel = UILabel().then {
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
    self.addSubview(verticalStackView)
    [
      profileImage,
      userName,
      nickName,
      horizontalStackView
    ].forEach { verticalStackView.addArrangedSubview($0) }
    
    [
      requestFriend,
      requestReference
    ].forEach { horizontalStackView.addArrangedSubview($0) }
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureUI(imageURL: String, userName: String, nickName: String) {
    self.userName.text = userName
    self.nickName.text = nickName
    if let url = URL(string: imageURL) {
      profileImage.kf.setImage(with: url)
    }
  }
  
  private func setConstraints() {
    verticalStackView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.horizontalEdges.equalToSuperview().inset(30)
      $0.height.equalTo(verticalStackView.snp.width)
    }
  }
}
