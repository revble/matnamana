//
//  BaseView.swift
//  matnamana
//
//  Created by 김윤홍 on 9/6/24.
//

import UIKit

import SnapKit
import Then

class BaseView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureUI() {
    
  }
  
  func setConstraints() {
    
  }
}
