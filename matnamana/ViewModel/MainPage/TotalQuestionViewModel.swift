//
//  TotalQuestionViewModel.swift
//  matnamana
//
//  Created by 김윤홍 on 9/5/24.
//

//import FirebaseCore
//import FirebaseFirestore
import RxCocoa
import RxSwift

final class TotalQuestionViewModel: ViewModelType {
  
  struct Input {
    let fetchQuestions: Observable<Void>
    let selectedSegment: Observable<Int>
  }
  
  struct Output {
    let questionList: Driver<[Question.Content]>
  }
  
  private func fetchQuestionList() -> Observable<[Question.Content]> {
    return Observable.create { observer in
      FirebaseManager.shared.getQuestionList(documentId: "questionId_789") { question, error in
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
    
    let filteredQuestion = Observable.combineLatest(questionList, input.selectedSegment) { questions, selectedIndex in
      return questions.filter { question in
        switch selectedIndex {
        case 0:
          return question.contentType == "fact"
        case 1:
          return question.contentType == "value"
        case 2:
          return question.contentType == "career"
        default:
          return false
        }
      }
      
    }
      
      .asDriver(onErrorJustReturn: [])
    return Output(questionList: filteredQuestion)
  }
}
