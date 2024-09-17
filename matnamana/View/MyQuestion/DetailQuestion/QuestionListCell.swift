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
    $0.font = .boldSystemFont(ofSize: 15)
  }
  
  let customButton = UIButton().then {
    let buttonImage = UIImage(systemName: "plus")
    $0.imageView?.contentMode = .scaleAspectFit
    $0.setImage(buttonImage, for: .normal)
    $0.contentMode = .scaleToFill
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
    questionLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().inset(20)
    }
    
    customButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().inset(10)
    }
  }
  
  func configureCell(questionCell: String) {
    questionLabel.text = questionCell
  }
}
