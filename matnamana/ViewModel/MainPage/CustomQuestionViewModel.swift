//
//  CustomQuestionViewModel.swift
//  matnamana
//
//  Created by 김윤홍 on 9/17/24.
//

import Foundation

import RxCocoa
import RxSwift

class CustomQuestionViewModel {
  
  var questions: [String]
  private let questionsRelay = BehaviorRelay<[String]>(value: [])
  
  init(presetQuestions: [String]) {
    self.questions = presetQuestions
    self.questionsRelay.accept(questions)
  }
  
  struct Input {
    let questions: Observable<Void>
  }
  
  struct Output {
    let questions: Driver<[String]>
  }
  
  func transform(input: Input) -> Output {
    let questionsDriver = questionsRelay.asDriver(onErrorJustReturn: [])
    return Output(questions: questionsDriver)
  }
  
  func updateQuestion(at index: Int, with question: String) {
    if questions.count < 5 {
      let emptyQuestions = Array(repeating: "새로운 질문을 추가해 보세요", count: 5 - questions.count)
      questions.append(contentsOf: emptyQuestions)
    }
    
    questions[index] = question
    questionsRelay.accept(questions)
  }
}
