//
//  AddNewQuestion.swift
//  matnamana
//
//  Created by 김윤홍 on 9/19/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class AddNewQuestionCell: UICollectionViewCell {

  var disposeBag = DisposeBag()
  
  var buttonTap: Observable<Void> {
    return addNewQuestion.rx.tap.asObservable()
  }
  
  let addNewQuestion = UIButton().then {
    $0.setTitle("+ 새 질문 만들기", for: .normal)
    $0.setTitleColor(UIColor.manaMainColor, for: .normal)
    $0.backgroundColor = .white
    $0.layer.borderColor = UIColor.manaMainColor.cgColor
    $0.layer.borderWidth = 1.0
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
    self.addSubview(addNewQuestion)
  }
  
  private func setConstraints() {
    addNewQuestion.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.horizontalEdges.equalToSuperview().inset(16)
      $0.height.equalTo(56)
    }
  }
}
