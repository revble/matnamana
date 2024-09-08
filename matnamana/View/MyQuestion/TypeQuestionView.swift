//
//  TypeQuestionView.swift
//  matnamana
//
//  Created by 김윤홍 on 9/7/24.
//

import UIKit

import SnapKit
import Then

final class TypeQuestionView: BaseView {
  
  let questionLabel = UILabel().then {
    $0.text = "새로운 질문"
    $0.font = .boldSystemFont(ofSize: 28)
    $0.textAlignment = .center
  }
  
  let questionTable = UITableView().then {
    $0.register(QuestionListCell.self, forCellReuseIdentifier: QuestionListCell.identifier)
    $0.rowHeight = 50
  }
  
  override func configureUI() {
    super.configureUI()
    [
      questionLabel,
      questionTable
    ].forEach { self.addSubview($0) }
  }
  
  override func setConstraints() {
    super.setConstraints()
    questionLabel.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide)
      $0.height.equalTo(100)
      $0.leading.trailing.equalToSuperview().inset(20)
    }
    
    questionTable.snp.makeConstraints {
      $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
      $0.top.equalTo(questionLabel.snp.bottom).offset(30)
      $0.bottom.equalTo(self.safeAreaLayoutGuide)
    }
  }
}
