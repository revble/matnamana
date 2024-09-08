//
//  questionListCell.swift
//  matnamana
//
//  Created by 김윤홍 on 9/4/24.
//

import UIKit

import SnapKit
import Then

final class QuestionListCell: UITableViewCell {

  static var identifier: String {
    return String(describing: self)
  }
  
  private let questionLabel = UILabel().then {
    $0.text = ""
    $0.numberOfLines = 0
    $0.font = .boldSystemFont(ofSize: 15)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    contentView.addSubview(questionLabel)
  }
  
  private func setConstraints() {
    questionLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.leading.equalToSuperview().inset(20)
    }
  }
  
  func configureCell(questionCell: String) {
    questionLabel.text = questionCell
  }
}
