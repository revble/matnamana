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
  
  private let myPageButton = UIButton(type: .system).then {
    var configuration = UIButton.Configuration.filled()
    configuration.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 35, bottom: 25, trailing: 35)
    configuration.baseBackgroundColor = UIColor(red: 219/255, green: 219/255, blue: 219/255, alpha: 1)// 기본 배경색 제거
    configuration.background.cornerRadius = 16 // border-radius: 16px
    
    $0.configuration = configuration
    
  
    $0.layer.cornerRadius = 16
    $0.layer.borderWidth = 1 // 테두리 두께
    $0.layer.borderColor = UIColor.lightGray.cgColor // 연한 회색 테두리
    $0.layer.shadowColor = UIColor.black.cgColor
//    $0.layer.shadowOffset = CGSize(width: 0, height: 4) // box-shadow 오프셋
//    $0.layer.shadowOpacity = 0.25 // box-shadow 투명도
//    $0.layer.shadowRadius = 4 // box-shadow 반경
//    $0.clipsToBounds = false // 그림자 보이도록 설정
  }
  
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
    $0.layer.cornerRadius = 70
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
  }
  
  let userName: UILabel = UILabel().then {
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
    $0.backgroundColor = .manaMainColor
    $0.layer.cornerRadius = 16
  }
  
  let requestReference: UIButton = UIButton().then {
    $0.setTitle("맞나만나 요청", for: .normal)
    $0.backgroundColor = .manaMainColor
    $0.layer.cornerRadius = 16
  }
  
  let deleteFriend: UIButton = UIButton().then {
    $0.setTitle("친구 해제", for: .normal)
    $0.backgroundColor = .manaMainColor
    $0.layer.cornerRadius = 16
  }
  
  let friendCount: UILabel = UILabel().then {
    $0.text = ""
    $0.textColor = .manaMainColor
    $0.font = .systemFont(ofSize: 17, weight: .semibold)
  }
  
  let shortDescription: UILabel = UILabel().then {
    $0.text = ""
    $0.font = .systemFont(ofSize: 17)
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
      myPageButton,
      horizontalStackView
    ].forEach { self.addSubview($0) }
    
    [
      profileImage,
      verticalStackView
    ].forEach { myPageButton.addSubview($0) }
    
    [
      userName,
      nickName,
//      friendCount,
      shortDescription
    ].forEach { verticalStackView.addArrangedSubview($0) }
    
    [
      deleteFriend,
      requestFriend,
      requestReference
    ].forEach { horizontalStackView.addArrangedSubview($0) }
    
  }
  
  func configureUI(imageURL: String, userName: String, nickName: String, /*friendCount: Int*/ shortDescription: String) {
    self.userName.text = userName
    self.nickName.text = "\(nickName)"
//    self.friendCount.text = "friendCount"
    self.shortDescription.text = shortDescription
    if let url = URL(string: imageURL) {
      profileImage.kf.setImage(with: url, placeholder: UIImage(named: "profile"))
      profileImage.kf.setImage(with: url)
    }
  }
  
  private func setConstraints() {
    
    myPageButton.snp.makeConstraints {
      $0.top.equalTo(safeAreaLayoutGuide).offset(18)
      $0.leading.equalToSuperview().offset(UIScreen.main.bounds.width * 0.2)
      $0.trailing.equalToSuperview().offset(-UIScreen.main.bounds.width * 0.2)
      $0.height.equalToSuperview().multipliedBy(0.4)
    }
    
    profileImage.snp.makeConstraints {
      $0.width.height.equalTo(140)
      $0.centerX.equalToSuperview()
      $0.top.equalTo(self.safeAreaLayoutGuide).inset(100)
    }
    
    verticalStackView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(profileImage.snp.bottom).offset(20)
    }
    
    horizontalStackView.snp.makeConstraints {
      $0.top.equalTo(myPageButton.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview().inset(50)
      $0.height.equalTo(40)
      $0.centerX.equalToSuperview()
    }
  }
}
