//
//  LoginView.swift
//  matnamana
//
//  Created by pc on 8/28/24.
//

import UIKit

import SnapKit
import Then

class RequiredInformationView: UIView {
  
  private let descriptionLabel = UILabel().then {
    $0.text = "서로를 알아볼 수 있는 정보를 입력해주세요."
    $0.numberOfLines = 2
    $0.textAlignment = .left
    $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
  }
  
  private let nameLabel = UILabel().then {
    $0.text = "이름"
    $0.textAlignment = .left
    $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
  }
  
  private let nameTextField = UITextField().then {
    $0.placeholder = "실명을 입력해주세요."
    $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    $0.layer.cornerRadius = 10
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor(.gray).cgColor
  }
  
  private let nickNameLabel = UILabel().then {
    $0.text = "닉네임"
    $0.textAlignment = .left
    $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
  }
  
  private let nickNameTextField = UITextField().then {
    $0.placeholder = "닉네임을 입력해주세요."
    $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    $0.layer.cornerRadius = 10
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor(.gray).cgColor
  }
  
  private let duplicateCheckLabel = UILabel().then {
    $0.text = "중복된 닉네임입니다."
    $0.textColor = .red
    $0.textAlignment = .left
    $0.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    $0.isHidden = true
  }
  
  
  let joinButton = UIButton().then {
    $0.setTitle("저장하기", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.backgroundColor = .manaGreen
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    setConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func pickNickname() -> String {
    guard let nickname = nickNameTextField.text else { return "" }
    return nickname
  }
  
  func pickName() -> String {
    guard let name = nameTextField.text else { return "" }
    return name
  }
  
  func showduplicateCheck() {
    duplicateCheckLabel.isHidden = false
  }
  
  func hideduplicateCheck() {
    duplicateCheckLabel.isHidden = true
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
