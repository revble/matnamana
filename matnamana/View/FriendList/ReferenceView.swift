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
  
  let questionTitle = UITextField().then {
    $0.text = ""
    $0.textColor = .black
    $0.font = .boldSystemFont(ofSize: 28)
    $0.textAlignment = .center
    $0.borderStyle = .none
  }
  
  let customTable = UITableView().then {
    $0.register(ReputationListCell.self, forCellReuseIdentifier: String(describing: ReputationListCell.self))
    $0.rowHeight = 80
    $0.separatorStyle = .none
  }
  
  let bottomBorder = UIView().then {
    $0.backgroundColor = .lightGray
  }
  
  let sendButton = UIButton().then {
    $0.setTitle("보내기", for: .normal)
    $0.backgroundColor = .manaMainColor
    $0.layer.cornerRadius = 16
  }
  
  override func configureUI() {
    super.configureUI()
    [bottomBorder].forEach { questionTitle.addSubview($0) }
    [
      questionTitle,
      customTable,
      sendButton
    ].forEach { self.addSubview($0) }
  }
  
  override func setConstraints() {
    super.setConstraints()
    
    questionTitle.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
      $0.horizontalEdges.equalToSuperview()
    }
    
    customTable.snp.makeConstraints {
      $0.top.equalTo(questionTitle.snp.bottom).offset(20)
      $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
      $0.height.equalTo(300)
    }
    
    sendButton.snp.makeConstraints {
      $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(50)
      $0.height.equalTo(56)
      $0.horizontalEdges.equalToSuperview().inset(104)
      $0.centerX.equalToSuperview()
    }
    
    bottomBorder.snp.makeConstraints {
      $0.height.equalTo(1)
      $0.horizontalEdges.equalToSuperview().inset(104)
      $0.bottom.equalToSuperview()
    }
  }
}
