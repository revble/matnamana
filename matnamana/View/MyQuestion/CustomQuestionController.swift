//
//  CustomQuestionController.swift
//  matnamana
//
//  Created by 김윤홍 on 9/12/24.
//

import UIKit

import RxCocoa
import RxSwift

class CustomQuestionController: BaseViewController {
  
  private var customQuestion = CustomQuestionView(frame: .zero)
  
  override func setupView() {
    super.setupView()
    customQuestion = CustomQuestionView(frame: UIScreen.main.bounds)
    self.view = customQuestion
  }
}
