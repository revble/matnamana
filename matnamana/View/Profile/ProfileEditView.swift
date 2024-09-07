//
//  ProfileEditViewController.swift
//  matnamana
//
//  Created by 이진규 on 8/30/24.
// 키보드올라올때 화면 올라가게
//
import UIKit

import SnapKit

class ProfileEditView: UIView {
  
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
  
  let nameTextField: UITextField = {
    let textField = UITextField()
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.black.cgColor
    textField.layer.cornerRadius = 5
    textField.placeholder = "이름을 입력해주세요"
    return textField
  }()
  
  let nickNameTextField: UITextField = {
    let textField = UITextField()
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.black.cgColor
    textField.layer.cornerRadius = 5
    textField.clearButtonMode = .always
    textField.placeholder = "닉네임을 입력해주세요"
    return textField
  }()
  
  let introduceTextField: UITextField = {
    let textField = UITextField()
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.black.cgColor
    textField.layer.cornerRadius = 5
    textField.clearButtonMode = .always
    textField.placeholder = "자기소개를 입력해주세요"
    return textField
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
    configureUI()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    [profilePage,
     profileImageView,
     nameTextField,
     nickNameTextField,
     introduceTextField,
     tableView
    ].forEach {
      addSubview($0)
    }
  }
  
  private func setConstraints() {
    profilePage.snp.makeConstraints {
      $0.top.equalTo(safeAreaLayoutGuide).offset(1)
      $0.leading.equalToSuperview().offset(24)
    }
    
    profileImageView.snp.makeConstraints {
      $0.top.equalTo(profilePage.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
      $0.width.height.equalTo(100)
    }
    
    nameTextField.snp.makeConstraints {
      $0.top.equalTo(profileImageView.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(20)
    }
    
    nickNameTextField.snp.makeConstraints {
      $0.top.equalTo(nameTextField.snp.bottom).offset(8)
      $0.centerX.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(20)
    }
    
    introduceTextField.snp.makeConstraints {
      $0.top.equalTo(nickNameTextField.snp.bottom).offset(8)
      $0.centerX.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(20)
    }
    
    tableView.snp.makeConstraints {
      $0.top.equalTo(introduceTextField.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
    }
  }
}
