//
//  AddFriendView.swift
//  matnamana
//
//  Created by 김윤홍 on 9/1/24.
//

import UIKit

import SnapKit
import Then

class AddFriendView: UIView {
  
  private let relationView = UIView().then {
    $0.backgroundColor = .white
  }
  
  let closeButton = UIButton().then {
    let image = UIImage(systemName: "xmark")
    $0.setImage(image, for: .normal)
    $0.tintColor = .lightGray
  }
  
  let friendButton = UIButton().then {
    $0.backgroundColor = .manaPink
    $0.setTitle("친구", for: .normal)
    $0.layer.cornerRadius = 10
  }
  
  let familyButton = UIButton().then {
    $0.backgroundColor = .manaMint
    $0.setTitle("가족", for: .normal)
    $0.layer.cornerRadius = 10
  }
  
  let colleagueButton = UIButton().then {
    $0.backgroundColor = .manaGreen
    $0.setTitle("동료", for: .normal)
    $0.layer.cornerRadius = 10
  }
  
  let sendButton = UIButton().then {
    $0.backgroundColor = .manaGreen
    $0.setTitle("보내기", for: .normal)
    $0.layer.cornerRadius = 10
  }
  
  private let label = UILabel().then {
    $0.textColor = .lightGray
    $0.textAlignment = .center
    $0.text = "상대방의 관계"
    $0.font = .boldSystemFont(ofSize: 25)
  }
  
  private let stackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 20
    $0.distribution = .fillEqually
  }
  
  private let horizontalStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 15
    $0.distribution = .fillEqually
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    configureUI()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    self.addSubview(relationView)
    [
      closeButton,
      stackView,
      sendButton
    ].forEach { relationView.addSubview($0) }
    
    [
      label,
      horizontalStackView,
    ].forEach { stackView.addArrangedSubview($0) }
    
    
    [familyButton, friendButton, colleagueButton].forEach { horizontalStackView.addArrangedSubview($0) }
  }
  
  private func setConstraints() {
    relationView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.horizontalEdges.equalToSuperview().inset(20)
      $0.verticalEdges.equalToSuperview().inset(300)
    }
    
    closeButton.snp.makeConstraints {
      $0.top.trailing.equalToSuperview().inset(20)
      $0.height.width.equalTo(20)
    }
    
    stackView.snp.makeConstraints {
      $0.top.equalTo(closeButton.snp.bottom).offset(10)
      $0.horizontalEdges.equalToSuperview().inset(10)
    }
    
    sendButton.snp.makeConstraints {
      $0.top.equalTo(stackView.snp.bottom).offset(20)
      $0.width.equalTo(200)
      $0.height.equalTo(50)
      $0.centerX.equalToSuperview()
      $0.bottom.equalToSuperview().inset(20)
    }
  }
}
