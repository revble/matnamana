//
//  CustomQuestionViewModel.swift
//  matnamana
//
//  Created by 김윤홍 on 9/17/24.
//

import RxCocoa
import RxSwift

class CustomQuestionViewModel {
  
  init(presetTitle: String, presetQuestions: [String]) {
    self.presetTitle = presetTitle
    self.presetQuestions = presetQuestions
  }
  
  private var presetTitle: String
  private var presetQuestions: [String]
  
  struct Input {
    let questions: Observable<Void>
  }
  
  struct Output {
    let title: Driver<String>
    let questions: Driver<[String]>
  }
  
  func transform(input: Input) -> Output {
    let title = Observable.just(presetTitle)
      .asDriver(onErrorJustReturn: "")
    
    let questions = input.questions
      .map { self.presetQuestions }
      .asDriver(onErrorJustReturn: [])
    
    return Output(title: title, questions: questions)
  }
}
