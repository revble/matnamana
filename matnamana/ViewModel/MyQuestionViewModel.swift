//
//  MyQuestionViewModel.swift
//  matnamana
//
//  Created by 김윤홍 on 9/5/24.
//

import FirebaseCore
import FirebaseFirestore
import RxCocoa
import RxSwift

final class MyQuestionViewModel: ViewModelType {
  
  struct Input {
    let fetchQuestions: Observable<Void>
  }
  
  struct Output {
    let questionList: Driver<[Question.Content]>
  }
  
  private let disposeBag = DisposeBag()
  
  private func fetchQuestionList() -> Observable<[Question.Content]> {
    return Observable.create { observer in
      FirebaseManager.shared.getQuestionList(documentId: "") { question, error in
        if let error = error {
          observer.onError(error)
        } else if let question = question {
          observer.onNext(question.contents)
          observer.onCompleted()
        } else {
          observer.onNext([])
          observer.onCompleted()
        }
      }
      return Disposables.create()
    }
  }
  
  func transform(input: Input) -> Output {
    let questionList = input.fetchQuestions
      .flatMap { [weak self] _ -> Observable<[Question.Content]> in
        guard let self = self else { return Observable.just([]) }
        return self.fetchQuestionList()
      }
      .asDriver(onErrorJustReturn: [])
    return Output(questionList: questionList)
  }
}
