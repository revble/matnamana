//
//  File.swift
//  matnamana
//
//  Created by 김윤홍 on 9/4/24.
//

import UIKit

import SnapKit
import Then

final class TotalQuestionView: UIView {
  
  let questionList = UITableView(frame: .zero, style: .insetGrouped).then {
    $0.register(QuestionListCell.self, forCellReuseIdentifier: QuestionListCell.identifier)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    self.addSubview(questionList)
  }
  
  private func setConstraints() {
    questionList.snp.makeConstraints {
      $0.edges.equalTo(self.safeAreaLayoutGuide).inset(20)
    }
  }
}
