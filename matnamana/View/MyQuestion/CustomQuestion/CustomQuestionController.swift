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
  private let viewModel: CustomQuestionViewModel
  private var selectedIndexPath: IndexPath?
  private var presetTitle: String
  
  init(viewModel: CustomQuestionViewModel, presetTitle: String) {
    self.viewModel = viewModel
    self.presetTitle = presetTitle
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setupView() {
    super.setupView()
    customQuestion = CustomQuestionView(frame: UIScreen.main.bounds)
    self.view = customQuestion
  }
  
  override func bind() {
    super.bind()
    
    let input = CustomQuestionViewModel.Input(questions: Observable.just(()))
    let output = viewModel.transform(input: input)
    
    output.questions
      .drive(customQuestion.customTable.rx.items(cellIdentifier: String(describing: QuestionListCell.self), cellType: QuestionListCell.self)) { [weak self] row, question, cell in
        cell.configureCell(questionCell: question)
        guard let self else { return }
        customQuestion.questionTitle.text = self.presetTitle
      }
      .disposed(by: disposeBag)
    
    customQuestion.customTable.rx.itemSelected
      .subscribe(onNext: { [weak self] indexPath in
        guard let self else { return }
        self.selectedIndexPath = indexPath
        
        let totalQuestionController = TotalQuestionController(isCustom: true)
        totalQuestionController.onQuestionSelected = { [weak self] selectedQuestion in
          guard let self,
                let selectedIndexPath = self.selectedIndexPath else { return }
          self.viewModel.updateQuestion(at: selectedIndexPath.row, with: selectedQuestion)
          self.updateSelectedCell(at: selectedIndexPath, with: selectedQuestion)
        }
        
        self.navigationController?.pushViewController(totalQuestionController, animated: true)
      }).disposed(by: disposeBag)
    
    customQuestion.saveButton.rx.tap
      .subscribe(onNext: { [weak self] in
        guard let self else { return }
        
        guard let id = UserDefaults.standard.string(forKey: "loggedInUserId"),
              let updatedQuestions = UserDefaults.standard.array(forKey: "savedQuestions") else { return }
        FirebaseManager.shared.updateField(in: .user, documentId: id, field: "preset", value: updatedQuestions) { success, error in
          if success {
            print("presetUpdate 성공")
          } else {
            print("실패")
          }
        }
      })
      .disposed(by: disposeBag)
  }
  
  private func updateSelectedCell(at indexPath: IndexPath, with question: String) {
    if let cell = customQuestion.customTable.cellForRow(at: indexPath) as? QuestionListCell {
      cell.configureCell(questionCell: question)
    }
  }
}
