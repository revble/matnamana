//
//  ProfileView.swift
//  matnamana
//
//  Created by 김윤홍 on 8/29/24.
//

import UIKit

import SnapKit

class ProfileView: UIView {
  
  private let profileImage: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage()
    return imageView
  }()
  
  private let userName: UILabel = {
    let label = UILabel()
    label.text = ""
    label.font = .boldSystemFont(ofSize: 20)
    return label
  }()
  
  private let nickName: UILabel = {
    let label = UILabel()
    label.text = ""
    label.font = .boldSystemFont(ofSize: 15)
    return label
  }()
  
  private let requestFriend: UIButton = {
    let button = UIButton()
    button.setTitle("친구 요청", for: .normal)
    button.backgroundColor = .manaGreen
    button.layer.cornerRadius = 10
    return button
  }()
  
  private let requestReference: UIButton = {
    let button = UIButton()
    button.setTitle("평판조회 신청", for: .normal)
    button.backgroundColor = .manaPink
    button.layer.cornerRadius = 10
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureUI()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureUI() {
    [
      profileImage,
      userName,
      nickName,
      requestFriend,
      requestReference
    ].forEach { self.addSubview($0) }
  }
  
  func setConstraints() {
    profileImage.snp.makeConstraints {
      $0.top.equalToSuperview().inset(100)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(profileImage.snp.height)
    }
    
    userName.snp.makeConstraints { make in
      make.top.equalTo(profileImage.snp.bottom).offset(15)
      make.left.right.equalToSuperview().inset(20)
    }
    
    nickName.snp.makeConstraints { make in
      make.top.equalTo(userName.snp.bottom).offset(10)
      make.left.right.equalToSuperview().inset(20)
    }
    
    requestFriend.snp.makeConstraints { make in
      make.top.equalTo(nickName.snp.bottom).offset(20)
      make.left.equalToSuperview().inset(20)
      make.right.equalTo(requestReference.snp.left).offset(-10)
      make.height.equalTo(44)
      make.width.equalTo(requestReference)
    }
    
    requestReference.snp.makeConstraints { make in
      make.top.equalTo(nickName.snp.bottom).offset(20)
      make.right.equalToSuperview().inset(20)
      make.left.equalTo(requestFriend.snp.right).offset(10)
      make.height.equalTo(44)
    }
  }
}
