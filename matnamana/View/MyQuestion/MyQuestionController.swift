//
//  SearchController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/23/24.
//

import UIKit

import RxCocoa
import RxSwift

final class myQuestionController: BaseViewController {
  
  private var viewModel = MyQuestionViewModel()
  private var myQuestionView = MyQuestionView(frame: .zero)
  
  override func setupView() {
    super.setupView()
    myQuestionView = MyQuestionView(frame: UIScreen.main.bounds)
    self.view = myQuestionView
  }
  
  override func setNavigation() {
    super.setNavigation()
    self.title = "홈"
  }
  
  override func bind() {
    let input = MyQuestionViewModel.Input(fetchQuestions: Observable.just(()))
    let output = viewModel.transform(input: input)
    
    output.questionList
      .drive(myQuestionView.questionList.rx
        .items(cellIdentifier: QuestionListCell.identifier,
               cellType: QuestionListCell.self)) { row, question, cell in
        cell.configureCell(questionCell: question.contentDescription)
      }.disposed(by: disposeBag)
  }
}
