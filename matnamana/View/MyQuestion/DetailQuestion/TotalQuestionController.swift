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
  private let isCustom: Bool
  var onQuestionSelected: ((String) -> Void)?
  
  init(isCustom: Bool) {
    self.isCustom = isCustom
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
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
               cellType: QuestionListCell.self)) { [weak self] row, question, cell in
        guard let self else { return }
        if self.isCustom {
          cell.customButton.isHidden = false
        } else {
          cell.customButton.isHidden = true
        }
        cell.configureCell(questionCell: question.contentDescription)
      }.disposed(by: disposeBag)
    
    totalQuestionView.questionList.rx.itemSelected
      .subscribe(onNext: { [weak self] indexPath in
        guard let self = self else { return }
        if let selectedCell = self.totalQuestionView.questionList.cellForRow(at: indexPath) as? QuestionListCell {
          let selectedQuestion = selectedCell.questionLabel.text ?? ""
          self.onQuestionSelected?(selectedQuestion)
        }
        
        self.navigationController?.popViewController(animated: true)
      }).disposed(by: disposeBag)
  }
}
