//
//  CustomQuestionCell.swift
//  matnamana
//
//  Created by 김윤홍 on 9/12/24.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

final class CustomQuestionCell: UICollectionViewCell {
  
  var selectedQuestion: User.PresetQuestion?
  var disposeBag = DisposeBag()
  
  var buttonTap: Observable<Void> {
    return customQuestionButton.rx.tap.asObservable()
  }
  
  let customQuestionButton = UIButton().then {
    $0.setTitle("", for: .normal)
    $0.backgroundColor = .manaMainColor
    $0.layer.cornerRadius = 16
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
    self.addSubview(customQuestionButton)
  }
  
  private func setConstraints() {
    
    customQuestionButton.snp.makeConstraints {
      $0.horizontalEdges.equalToSuperview().inset(16)
      $0.height.equalTo(56)
    }
  }
  
  func configure(title: String, question: User.PresetQuestion) {
    customQuestionButton.setTitle(title, for: .normal)
    selectedQuestion = question
  }
}
