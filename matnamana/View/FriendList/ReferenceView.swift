//
//  ReferenceView.swift
//  matnamana
//
//  Created by 김윤홍 on 9/6/24.
//

import UIKit

import SnapKit
import Then

final class ReferenceView: BaseView {
  
  private let titleLabel = UILabel().then {
    $0.text = "Best 질문"
    $0.font = .boldSystemFont(ofSize: 28)
  }
  
  let questions: [UILabel] = (0..<5).map { _ in
    UILabel().then {
      $0.text = "질문"
      $0.textAlignment = .center
      $0.numberOfLines = 0
    }
  }
  
  let sendButton = UIButton().then {
    $0.setTitle("보내기", for: .normal)
    $0.backgroundColor = .manaGreen
    $0.layer.cornerRadius = 10
  }
  
  private let questionStackView = UIStackView().then {
    $0.axis = .vertical
    $0.distribution = .fillEqually
    $0.spacing = 10
  }
  
  override func configureUI() {
    [
      titleLabel,
      questionStackView,
      sendButton
    ].forEach { self.addSubview($0) }
    
    questions.forEach { questionStackView.addArrangedSubview($0) }
  }
  
  override func setConstraints() {
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide)
      $0.centerX.equalToSuperview()
    }
    
    questionStackView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(30)
      $0.horizontalEdges.equalToSuperview()
      $0.bottom.equalTo(sendButton.snp.top).offset(-30)
    }
    
    sendButton.snp.makeConstraints {
      $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(150)
      $0.height.equalTo(40)
      $0.width.equalTo(200)
      $0.centerX.equalToSuperview()
    }
  }
}
