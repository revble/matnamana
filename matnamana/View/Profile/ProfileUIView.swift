//
//  ProfileView.swift
//  matnamana
//
//  Created by 이진규 on 9/2/24.
//

import UIKit

import SnapKit

class ProfileUIView: UIView {
  
  let profilePage: UILabel = {
    let label = UILabel()
    label.text = "나의 정보"
    label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
    return label
  }()
  
  let profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "profile")
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 50
    imageView.clipsToBounds = true
    imageView.isUserInteractionEnabled = true
    return imageView
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "이름"
    label.layer.borderWidth = 1.0
    label.layer.borderColor = UIColor.black.cgColor
    label.layer.cornerRadius = 5
    label.textAlignment = .center
    return label
  }()
  
  let nickNameLabel: UILabel = {
    let label = UILabel()
    label.text = "닉네임"
    label.layer.borderWidth = 1.0
    label.layer.borderColor = UIColor.black.cgColor
    label.layer.cornerRadius = 5
    label.textAlignment = .center
    return label
  }()
  
  let introduceLabel: UILabel = {
    let label = UILabel()
    label.text = "자기소개"
    label.layer.borderWidth = 1.0
    label.layer.borderColor = UIColor.black.cgColor
    label.layer.cornerRadius = 5
    label.textAlignment = .center
    return label
  }()
  
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 44
    return tableView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    [
      profilePage,
      nameLabel,
      profileImageView,
      tableView,
      nickNameLabel,
      introduceLabel
    ].forEach {
      addSubview($0)
    }
  }
  
  private func setConstraints() {
    profilePage.snp.makeConstraints {
      $0.top.equalTo(safeAreaLayoutGuide).offset(8)
      $0.leading.equalToSuperview().offset(24)
    }
    
    profileImageView.snp.makeConstraints {
      $0.top.equalTo(profilePage.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
      $0.width.height.equalTo(100)
    }
    
    nameLabel.snp.makeConstraints {
      $0.top.equalTo(profileImageView.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(20)
    }
    
    nickNameLabel.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(8)
      $0.centerX.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(20)
    }
    
    introduceLabel.snp.makeConstraints {
      $0.top.equalTo(nickNameLabel.snp.bottom).offset(8)
      $0.centerX.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(20)
    }
    
    tableView.snp.makeConstraints {
      $0.top.equalTo(introduceLabel.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.bottom.equalToSuperview()
    }
  }
}
