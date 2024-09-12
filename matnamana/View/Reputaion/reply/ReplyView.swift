//
//  ReplyView.swift
//  matnamana
//
//  Created by pc on 9/12/24.
//

import UIKit
import SnapKit
import Then

final class ReplyView: BaseView {
  
  private let titleLabel = UILabel().then {
    $0.text = "박동현님은 어떤 분인가요?"
    $0.font = .boldSystemFont(ofSize: 28)
  }
  
  let tableView = UITableView().then {
    $0.register(UITableViewCell.self, forCellReuseIdentifier: "QuestionCell")
    $0.rowHeight = UITableView.automaticDimension
    $0.estimatedRowHeight = 44
    $0.isScrollEnabled = false
  }
  
  let sendButton = UIButton().then {
    $0.setTitle("보내기", for: .normal)
    $0.backgroundColor = .manaGreen
    $0.layer.cornerRadius = 10
  }
  
  func reName(name: String) {
    titleLabel.text = "\(name)님은 어떤 분인가요?"
  }
  
  override func configureUI() {
    super.configureUI()
    [
      titleLabel,
      tableView,
      sendButton
    ].forEach { self.addSubview($0) }
  }
  
  override func setConstraints() {
    super.setConstraints()
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide)
      $0.centerX.equalToSuperview()
    }
    
    tableView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(30)
      $0.left.equalToSuperview().offset(30)
      $0.right.equalToSuperview().offset(-30)
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
