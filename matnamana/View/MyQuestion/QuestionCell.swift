//
//  QuestionCell.swift
//  matnamana
//
//  Created by 김윤홍 on 9/12/24.
//

import UIKit

import SnapKit
import Then

final class QuestionCell: UICollectionViewCell {
  
  private let totalQuestionButton = UIButton().then {
    $0.backgroundColor = .manaMainColor
    $0.setTitle("전체 질문 리스트", for: .normal)
  }
  
  private let coupleQuestonButton = UIButton().then {
    $0.setTitle("연애질문", for: .normal)
  }
  
  private let simpleMannamButton = UIButton().then {
    $0.setTitle("느슨한 만남", for: .normal)
  }
  
  private let bussinessButton = UIButton().then {
    $0.setTitle("비즈니스", for: .normal)
  }
  
  private let buttonStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 10
    $0.distribution = .fillEqually
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
    [
      coupleQuestonButton,
      simpleMannamButton,
      bussinessButton
    ].forEach { buttonStackView.addArrangedSubview($0) }
    
    [
      totalQuestionButton,
      buttonStackView
    ].forEach { contentView.addSubview($0) }
  }
  
  private func setConstraints() {
    
    totalQuestionButton.snp.makeConstraints {
      $0.top.horizontalEdges.equalToSuperview()
    }
    
    buttonStackView.snp.makeConstraints {
      $0.top.equalTo(totalQuestionButton.snp.bottom).offset(10)
      $0.horizontalEdges.equalToSuperview().offset(20)
      $0.bottom.equalToSuperview()
    }
  }
}
