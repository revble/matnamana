//
//  CustomQuestionView.swift
//  matnamana
//
//  Created by 김윤홍 on 9/12/24.
//

import UIKit

class CustomQuestionView: BaseView {
  
  private let questionTitle = UILabel().then {
    $0.text = "새로운 질문"
    $0.font = .boldSystemFont(ofSize: 28)
    $0.textAlignment = .center
  }
  
  private let questionStack = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 30
    $0.distribution = .fillEqually
  }
  
  private let customTable = UITableView().then {
    $0.backgroundColor = .black
  }
  
  override func configureUI() {
    super.configureUI()
    [
      questionTitle,
      customTable
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
      $0.bottom.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(10)
    }
  }
}
