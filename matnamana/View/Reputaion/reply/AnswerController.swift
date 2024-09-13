//
//  AnswerController.swift
//  matnamana
//
//  Created by pc on 9/12/24.
//

import UIKit

import RxCocoa
import RxSwift

final class AnswerController: BaseViewController {
  private var answerView = AnswerView(frame: .zero)
  private var replyViewModel: ReplyViewModel
  private var name: String
  private var question: String
  
  init(replyViewModel: ReplyViewModel, name: String, question: String) {
    self.replyViewModel = replyViewModel
    self.name = name
    self.question = question
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func bind() {
    super.bind()
    setupDismissKeyboardGesture()
    
    answerView.sendButton.rx.tap
      .withLatestFrom(answerView.textView.rx.text.orEmpty)
      .subscribe(onNext: { [weak self] text in
        guard let self else { return }
        self.replyViewModel.saveAnswer(question: self.question, answer: text)
        self.popViewController()
      }).disposed(by: disposeBag)
    
  }
  
  override func setupView() {
    super.setupView()
    answerView = AnswerView(frame: UIScreen.main.bounds)
    self.view = answerView
    answerView.selectedQuestion(name: name, question: question)
  }
  
}
