//
//  ReadAnswerView.swift
//  matnamana
//
//  Created by pc on 9/14/24.
//

import UIKit

final class ReadAnswerView: BaseView {
  private let titleLabel = UILabel().then {
    $0.text = "박동현님은 어떤 분인가요?"
    $0.font = .boldSystemFont(ofSize: 28)
  }
  
  let sendButton = UIButton().then {
    $0.setTitle("보내기", for: .normal)
    $0.backgroundColor = .manaMainColor
    $0.layer.cornerRadius = 10
    $0.isEnabled = false
  }
  
  func reName(name: String) {
    titleLabel.text = "\(name)님은 어떤 분인가요?"
  }
  
  override func configureUI() {
    super.configureUI()
    [
      titleLabel,
      sendButton
    ].forEach { self.addSubview($0) }
  }
  
  override func setConstraints() {
    super.setConstraints()
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide)
      $0.centerX.equalToSuperview()
    }

    
    sendButton.snp.makeConstraints {
      $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(150)
      $0.height.equalTo(40)
      $0.width.equalTo(200)
      $0.centerX.equalToSuperview()
    }
  }
  
}
