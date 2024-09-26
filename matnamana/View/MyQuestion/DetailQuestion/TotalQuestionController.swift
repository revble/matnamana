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
  private let addQuestion: Bool
  private var selectedQuestions = [String]()
  var onQuestionSelected: ((String) -> Void)?
  
  init(isCustom: Bool,
       addQuestion: Bool) {
    self.isCustom = isCustom
    self.addQuestion = addQuestion
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
    
    if addQuestion {
      let rightButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet.rectangle.portrait"), style: .plain, target: nil, action: nil)
      navigationItem.rightBarButtonItem = rightButton
      
      rightButton.rx.tap
        .subscribe(onNext: { [weak self] in
          guard let self else { return }
          let viewModel = CustomQuestionViewModel(presetQuestions: selectedQuestions)
          self.navigationController?.pushViewController(CustomQuestionController(viewModel: viewModel,
                                                                                 presetTitle: "새로운 질문",
                                                                                 addMode: true, cellIndexPath: 0
                                                                                ), animated: true)
        })
        .disposed(by: disposeBag)
    }
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
        if self.addQuestion {
          cell.customButton.isHidden = false
          let image = UIImage(systemName: "plus")
          cell.customButton.setImage(image, for: .normal)
          cell.customButton.setTitle("", for: .normal)
        } else {
          cell.customButton.isHidden = true
        }
        cell.configureCell(questionCell: question.contentDescription)
      }.disposed(by: disposeBag)
    
    totalQuestionView.questionList.rx.itemSelected
      .subscribe(onNext: { [weak self] indexPath in
        guard let self else { return }
        if let selectedCell = self.totalQuestionView.questionList.cellForRow(at: indexPath) as? QuestionListCell {
          let selectedQuestion = selectedCell.questionLabel.text ?? ""
          self.onQuestionSelected?(selectedQuestion)
        }
        if !addQuestion {
          self.navigationController?.popViewController(animated: true)
        } else {
          if let selectedCell = self.totalQuestionView.questionList.cellForRow(at: indexPath) as? QuestionListCell {
            let selectedQuestion = selectedCell.questionLabel.text ?? ""
            if !selectedQuestions.contains(selectedQuestion) {
              self.selectedQuestions.append(selectedQuestion)
            }
            self.onQuestionSelected?(selectedQuestion)
          }
        }
      }).disposed(by: disposeBag)
  }
}
