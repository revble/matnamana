//
//  CustomQuestionView.swift
//  matnamana
//
//  Created by 김윤홍 on 9/12/24.
//

import UIKit

final class CustomQuestionView: BaseView {

  let questionTitle = UITextField().then {
    $0.text = ""
    $0.textColor = .black
    $0.font = .boldSystemFont(ofSize: 28)
    $0.textAlignment = .center
    $0.borderStyle = .none
    $0.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
  }
  
  let customTable = UITableView().then {
    $0.register(QuestionListCell.self, forCellReuseIdentifier: String(describing: QuestionListCell.self))
    $0.rowHeight = 80
    $0.separatorStyle = .none
  }
  
  let saveButton = UIButton().then {
    $0.setTitle("작성완료", for: .normal)
    $0.backgroundColor = .manaMainColor
    $0.layer.cornerRadius = 16
    $0.frame = CGRect(x: 0, y: 0, width: 200, height: 56)
  }

  override func configureUI() {
    super.configureUI()
    
    saveButton.frame = CGRect(x: 0, y: 0, width: self.frame.width - 300, height: 56)
    customTable.tableHeaderView = questionTitle
    customTable.tableFooterView = saveButton

    self.addSubview(customTable)
  }

  override func setConstraints() {
    super.setConstraints()

    customTable.snp.makeConstraints {
      $0.edges.equalTo(self.safeAreaLayoutGuide).inset(32)
    }
    customTable.layoutIfNeeded()
  }
}
