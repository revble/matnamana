//
//  TableViewCell.swift
//  matnamana
//
//  Created by 김윤홍 on 8/27/24.
//

import UIKit

class FriendListCell: UITableViewCell {
  
  static let identifier = "friendCell"
  
  private let userImage: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 50
    return imageView
  }()
  
  private let userName: UILabel = {
    let label = UILabel()
    label.text = ""
    return label
  }()
  
  private let userRelation: UILabel = {
    let label = UILabel()
    label.text = "친구"
    return label
  }()
  
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
      //$0.width.height.equalTo(contentView.snp.height).multipliedBy(0.7)
      $0.width.height.equalTo(100)
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
  
  func configureCell(nickName: String, relation: String) {
    userName.text = nickName
    userRelation.text = relation
  }
}
