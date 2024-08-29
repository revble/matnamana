//
//  LoginView.swift
//  matnamana
//
//  Created by pc on 8/28/24.
//

import UIKit
import SnapKit

class RequiredInformationView: UIView {
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage()
    return imageView
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "서로를 알아볼 수 있는 정보를 입력해주세요."
    label.numberOfLines = 2
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
    return label
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "이름"
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    return label
  }()
  
  private let nameTextField: UITextField = {
    let textField = UITextField()
    textField.text = ""
    textField.placeholder = "실명을 입력해주세요."
    textField.layer.cornerRadius = 10
    textField.layer.borderWidth = 1
    textField.layer.borderColor = UIColor(.gray).cgColor
    textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    return textField
  }()
  
  private let nickNameLabel: UILabel = {
    let label = UILabel()
    label.text = "닉네임"
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    return label
  }()
  
  private let nickNameTextField: UITextField = {
    let textField = UITextField()
    textField.text = ""
    textField.placeholder = "닉네임을 입력해주세요."
    textField.layer.cornerRadius = 10
    textField.layer.borderWidth = 1
    textField.layer.borderColor = UIColor(.gray).cgColor
    textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    return textField
  }()
  
  private let duplicateCheckLabel: UILabel = {
    let label = UILabel()
    label.text = "중복된 닉네임입니다."
    label.textColor = .red
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    return label
  }()
  
  
  private let joinButton: UIButton = {
    let button = UIButton()
    button.setTitle("저장하기", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .green
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    setConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    self.backgroundColor = .white
    [
      descriptionLabel,
      nameLabel,
      nameTextField,
      nickNameLabel,
      nickNameTextField,
      duplicateCheckLabel,
      joinButton
    ].forEach { self.addSubview($0) }
  }
  
  private func setConstraint() {
    
    descriptionLabel.snp.makeConstraints {
      $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(150)
      $0.leading.equalToSuperview().inset(20)
      $0.width.equalTo(250)
    }
    
    nameLabel.snp.makeConstraints {
      $0.top.equalTo(descriptionLabel.snp.bottom).offset(40)
      $0.leading.trailing.equalToSuperview().inset(20)
    }
    
    nameTextField.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(8)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.height.equalTo(50)
    }
    
    nickNameLabel.snp.makeConstraints {
      $0.top.equalTo(nameTextField.snp.bottom).offset(16)
      $0.leading.trailing.equalToSuperview().inset(20)
    }
    
    nickNameTextField.snp.makeConstraints {
      $0.top.equalTo(nickNameLabel.snp.bottom).offset(8)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.height.equalTo(50)
    }
    
    duplicateCheckLabel.snp.makeConstraints {
      $0.top.equalTo(nickNameTextField.snp.bottom).offset(8)
      $0.leading.trailing.equalToSuperview().inset(20)
    }
    
    joinButton.snp.makeConstraints {
      $0.bottom.equalToSuperview().inset(50)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(250)
      $0.height.equalTo(50)
    }
  }
}
