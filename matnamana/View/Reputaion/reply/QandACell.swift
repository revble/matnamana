//
//  QandACell.swift
//  matnamana
//
//  Created by pc on 9/19/24.
//

import UIKit

import Then
import SnapKit

final class QandACell: UITableViewCell {
  
  private let question = UILabel().then {
    $0.text = "질문:"
    $0.font = UIFont.headLine()
  }
  
  private let questionText = UILabel().then {
    $0.text = ""
    $0.font = UIFont.headLine()
  }
  
  private let questionStackView = UIStackView().then {
    $0.axis = .horizontal
  }
  
  private let answer = UILabel().then {
    $0.text = "답변:"
    $0.font = UIFont.bonmoon()
  }
  
  private let answerText = UILabel().then {
    $0.text = ""
    $0.font = UIFont.bonmoon()
  }
  
  private let answerStackView = UIStackView().then {
    $0.axis = .horizontal
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    [
      questionStackView,
      answerStackView
    ].forEach { self.addSubview($0) }
    
    [
      question,
      questionText
    ].forEach { questionStackView.addArrangedSubview($0) }
    
    [
      answer,
      answerText
    ].forEach { answerStackView.addArrangedSubview($0) }
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setConstraints() {
    question.snp.makeConstraints {
      $0.width.equalTo(50)
    }
    answer.snp.makeConstraints {
      $0.width.equalTo(50)
    }
    questionStackView.snp.makeConstraints {
      $0.top.equalToSuperview()
    }
    answerStackView.snp.makeConstraints {
      $0.top.equalTo(questionStackView.snp.bottom).offset(10)
    }
    
  }
  
  func configure(with questionList: QuestionList, userId: String) {
    questionText.text = questionList.contentDescription
    answerText.text = questionList.answer?[userId]?.description
  }
}
