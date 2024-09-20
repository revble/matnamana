//
//  ReplyView.swift
//  matnamana
//
//  Created by pc on 9/12/24.
//

import UIKit

import SnapKit
import Then

final class AnswerView: BaseView {
  
  private let titleLabel = UILabel().then {
    $0.text = "박동현님에 대한 질문"
    $0.font = .boldSystemFont(ofSize: 28)
  }
  
  private let questionLabel = UILabel().then {
    $0.text = "질문"
    $0.textAlignment = .center
    $0.numberOfLines = 0
    $0.font = UIFont.boldSystemFont(ofSize: 22)
  }
  
  let textView = UITextView().then {
    $0.font = UIFont.systemFont(ofSize: 16)
    $0.textColor = .black
    $0.isEditable = true
    $0.isScrollEnabled = false
    $0.layer.borderColor = UIColor.gray.cgColor
    $0.layer.borderWidth = 1.0
    $0.layer.cornerRadius = 5.0
    $0.returnKeyType = .default // 줄바꿈을 위한 설정
  }
  
  let sendButton = UIButton().then {
    $0.setTitle("확인", for: .normal)
    $0.backgroundColor = .manaMainColor
    $0.layer.cornerRadius = 10
  }
  
  func selectedQuestion(name: String, question: String) {
    titleLabel.text = "\(name)님에 대한 질문"
    questionLabel.text = "Q.\(question)"
  }
  
  
  override func configureUI() {
    super.configureUI()
    [
      questionLabel,
      textView,
      sendButton
    ].forEach { self.addSubview($0) }
  }
  
  override func setConstraints() {
    super.setConstraints()
    
    questionLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(100)
      $0.left.equalToSuperview().offset(30)
      $0.right.equalToSuperview().offset(-30)
      $0.centerX.equalToSuperview()
    }
    
    textView.snp.makeConstraints {
      $0.bottom.equalTo(sendButton.snp.top).offset(-30)
      $0.left.equalToSuperview().offset(30)
      $0.right.equalToSuperview().offset(-30)
      $0.height.equalTo(150)
    }
    
    sendButton.snp.makeConstraints {
      $0.height.equalTo(40)
      $0.width.equalTo(200)
      $0.centerY.equalToSuperview().offset(50)
      $0.centerX.equalToSuperview()
    }
  }
}
