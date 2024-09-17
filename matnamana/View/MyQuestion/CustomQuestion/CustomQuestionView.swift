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
  
  let customTable = UITableView().then {
    $0.register(QuestionListCell.self, forCellReuseIdentifier: String(describing: QuestionListCell.self))
    $0.backgroundColor = .black
  }
  
  private let saveButton = UIButton().then {
    $0.setTitle("저장하기", for: .normal)
    $0.backgroundColor = .manaMainColor
  }

  override func configureUI() {
    super.configureUI()
    [
      questionTitle,
      customTable,
      saveButton
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
      $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(30)
      $0.bottom.equalTo(saveButton.snp.top).offset(-50)
    }
    
    saveButton.snp.makeConstraints {
      $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(50)
      $0.height.equalTo(50)
      $0.centerX.equalToSuperview()
    }
  }
}
