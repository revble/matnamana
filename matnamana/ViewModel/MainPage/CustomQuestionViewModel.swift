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
  
  private var questions: [String]
  private let questionsRelay = BehaviorRelay<[String]>(value: [])
  private let userDefaultsKey = "savedQuestions"
  
  init(presetQuestions: [String]) {
    if let savedQuestions = UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] {
      self.questions = savedQuestions
    } else {
      self.questions = presetQuestions
    }
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
    questions[index] = question
    questionsRelay.accept(questions)
    saveQuestions()
  }
  
  private func saveQuestions() {
    UserDefaults.standard.set(questions, forKey: userDefaultsKey)
  }
}
