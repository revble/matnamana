//
//  SearchController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/23/24.
//

import UIKit

import RxCocoa
import RxSwift

final class TotalQuestionController: BaseViewController {
  
  private var viewModel = TotalQuestionViewModel()
  private var totalQuestionView = TotalQuestionView(frame: .zero)
  
  override func setupView() {
    super.setupView()
    totalQuestionView = TotalQuestionView(frame: UIScreen.main.bounds)
    self.view = totalQuestionView
  }
  
  override func setNavigation() {
    super.setNavigation()
    self.title = "전체 질문 리스트"
  }
  
  override func bind() {
    let input = TotalQuestionViewModel.Input(
      fetchQuestions: Observable.just(()),
      selectedSegment: totalQuestionView.questionSegement.rx.selectedSegmentIndex.asObservable()
    )
    let output = viewModel.transform(input: input)
    
    output.questionList
      .drive(totalQuestionView.questionList.rx
        .items(cellIdentifier: String(describing: QuestionListCell.self),
               cellType: QuestionListCell.self)) { row, question, cell in
        cell.configureCell(questionCell: question.contentDescription)
      }.disposed(by: disposeBag)
  }
}
