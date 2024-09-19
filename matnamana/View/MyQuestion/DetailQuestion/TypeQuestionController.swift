//
//  TypeQuestionController.swift
//  matnamana
//
//  Created by 김윤홍 on 9/7/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class TypeQuestionController: BaseViewController {
  private var typeQuestionView = TypeQuestionView(frame: .zero)
  private var viewModel: TypeQuestionViewModel
  private var titleLabel: String
  
  init(viewModel: TypeQuestionViewModel, title: String) {
    self.viewModel = viewModel
    self.titleLabel = title
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setNavigation() {
    super.setNavigation()
    self.title = titleLabel
  }
  
  override func setupView() {
    super.setupView()
    typeQuestionView = TypeQuestionView(frame: UIScreen.main.bounds)
    self.view = typeQuestionView
  }
  
  override func bind() {
    super.bind()
    let input = TypeQuestionViewModel.Input(fetchQuestions: Observable.just(()))
    let output = viewModel.transform(input: input)
    
    output.questionList
      .drive(typeQuestionView.questionTable.rx
        .items(cellIdentifier: QuestionListCell.identifier,
               cellType: QuestionListCell.self)) { [weak self] row, question, cell in
        guard let self else { return }
        cell.configureCell(questionCell: String("\(row + 1). \(question.contentDescription)"))
        cell.customButton.isHidden = true
        self.typeQuestionView.questionTable.separatorStyle = .none
      }.disposed(by: disposeBag)
  }
}
