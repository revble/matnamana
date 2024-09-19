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
  
  let questionTable = UITableView().then {
    $0.register(QuestionListCell.self, forCellReuseIdentifier: String(describing: QuestionListCell.self))
    $0.rowHeight = 80
  }
  
  override func configureUI() {
    super.configureUI()
    [
      questionTable
    ].forEach { self.addSubview($0) }
  }
  
  override func setConstraints() {
    super.setConstraints()

    questionTable.snp.makeConstraints {
      $0.edges.equalTo(self.safeAreaLayoutGuide).inset(16)
    }
  }
}
