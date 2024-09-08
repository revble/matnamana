//
//  TableViewCell.swift
//  matnamana
//
//  Created by 김윤홍 on 8/27/24.
//

import UIKit

import Then

final class FriendListCell: UITableViewCell {

  private let userImage = UIImageView().then {
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 25
    $0.contentMode = .scaleAspectFit
  }
  
  private let userName = UILabel().then {
    $0.text = ""
  }
  
  private let userRelation = UILabel().then {
    $0.text = "친구"
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    [
      userImage,
      userName,
      userRelation
    ].forEach { contentView.addSubview($0) }
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setConstraints() {
    userImage.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(20)
      $0.centerY.equalToSuperview()
      $0.width.height.equalTo(50)
    }
    
    userName.snp.makeConstraints {
      $0.leading.equalTo(userImage.snp.trailing).offset(20)
      $0.top.equalTo(userImage.snp.top)
    }
    
    userRelation.snp.makeConstraints {
      $0.top.equalTo(userName.snp.bottom).offset(5)
      $0.leading.equalTo(userName.snp.leading)
    }
  }
  
  func configureCell(nickName: String, relation: String, friendImage: String) {
    userName.text = nickName
    
    if let url = URL(string: friendImage) {
      userImage.kf.setImage(with: url)
    }
    
    switch relation.lowercased() {
    case "friend":
      userRelation.text = "친구"
    case "family":
      userRelation.text = "가족"
    case "colleague":
      userRelation.text = "동료"
    default:
      userRelation.text = relation
    }
  }
}
