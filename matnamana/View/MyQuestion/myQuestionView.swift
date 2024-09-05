//
//  File.swift
//  matnamana
//
//  Created by 김윤홍 on 9/4/24.
//

import UIKit

import SnapKit
import Then

class myQuestionView: UIView {
  
  private let totalList = UIButton().then {
    $0.setTitle("전체 질문 리스트", for: .normal)
  }
  
  private let questionList = UITableView().then {
    $0.register(
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
}
