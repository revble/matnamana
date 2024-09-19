//
//  AnswerListView.swift
//  matnamana
//
//  Created by pc on 9/17/24.
//

import UIKit

import Then
import SnapKit

final class AnswerListView: BaseView {
  
  private let descriptionLabel = UILabel().then {
    $0.text = "작성된 답변은 상대방에게 노출되지 않습니다."
    $0.font = UIFont.headLine()
    $0.textColor = .orange
  }
  
  var tableView = UITableView().then {
    $0.register(AnswerListCell.self, forCellReuseIdentifier: String(describing: AnswerListCell.self))
    $0.estimatedRowHeight = 100
    $0.rowHeight = UITableView.automaticDimension
  }
  
  let button = UIButton(type: .system).then {
    $0.setTitle("확인완료", for: .normal)
    $0.backgroundColor = .manaMainColor
    $0.setTitleColor(.white, for: .normal)
    $0.layer.cornerRadius = 15
  }
  
  override func configureUI() {
    super.configureUI()
    [
      descriptionLabel,
      tableView,
      button
    ].forEach { self.addSubview($0) }
  }
  
  override func setConstraints() {
    super.setConstraints()
    
    descriptionLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(146)
      $0.left.equalToSuperview().inset(20)
    }
    
    tableView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(300)
    }
    
    button.snp.makeConstraints {
      $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(50)
      $0.height.equalTo(40)
      $0.width.equalTo(200)
      $0.centerX.equalToSuperview()
    }
    
  }
  
}
