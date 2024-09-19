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
  
  let questionLabel = UILabel().then {
    $0.text = ""
    $0.numberOfLines = 0
    $0.font = .systemFont(ofSize: 17, weight: .semibold)
  }
  
  let customButton = UIButton().then {
    $0.setTitle("수정", for: .normal)
    $0.setTitleColor(.manaMainColor, for: .normal)
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
    [
      questionLabel,
      customButton
    ].forEach { contentView.addSubview($0) }
  }
  
  private func setConstraints() {
    
    customButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.width.equalTo(35)
    }
    
    questionLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview()
      $0.trailing.equalTo(customButton.snp.leading).offset(-10)
    }
  }
  
  func configureCell(questionCell: String) {
    questionLabel.text = questionCell
  }
}
