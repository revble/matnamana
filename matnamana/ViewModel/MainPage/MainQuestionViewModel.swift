//
//  MainQuestionViewModel.swift
//  matnamana
//
//  Created by 김윤홍 on 9/7/24.
//

import RxSwift
import RxCocoa
import Foundation

final class MainQuestionViewModel: ViewModelType {
  
  struct Input {
    let totalButtonTap: Observable<Void>
    let coupleButtonTap: Observable<Void>
    let simpleMannamButtonTap: Observable<Void>
    let businessButtonTap: Observable<Void>
    let fetchQuestions: Observable<Void>
  }
  
  struct Output {
    let navigateTo: Observable<Destination>
    let questionList: Driver<[User.PresetQuestion]>
    let presetTitles: Driver<[String]>
    let presetQuestions: Driver<[User.PresetQuestion]>
  }
  
  enum Destination {
    case totalQuestion
    case coupleQuestion
    case simpleMannam
    case business
  }
  
  func fetchQuestionList() -> Observable<[User.PresetQuestion]> {
    guard let id = UserDefaults.standard.string(forKey: "loggedInUserId") else { return Observable.just([]) }
    return Observable.create { observer in
      FirebaseManager.shared.getPresetList(documentId: id) { question, error in
        if let error = error {
          print("error")
          observer.onError(error)
        } else if let question = question {
          observer.onNext(question)
          print("Firebase data fetched: \(question)")
          observer.onCompleted()
        } else {
          print("no")
          observer.onNext([])
          observer.onCompleted()
        }
      }
      return Disposables.create()
    }
  }
  
  func transform(input: Input) -> Output {
    let navigateTo = Observable.merge(
      input.totalButtonTap.map { Destination.totalQuestion },
      input.coupleButtonTap.map { Destination.coupleQuestion },
      input.simpleMannamButtonTap.map { Destination.simpleMannam },
      input.businessButtonTap.map { Destination.business }
    )
    
    let preset = input.fetchQuestions
      .flatMap { [weak self] _ -> Observable<[User.PresetQuestion]> in
        guard let self else { return Observable.just([]) }
        return self.fetchQuestionList()
      }
      .share(replay: 1)
    let presetTitles = preset
      .map { $0.map { $0.presetTitle} }
      .asDriver(onErrorJustReturn: [])
    
    let presetQuestions = preset
          .asDriver(onErrorJustReturn: [])
    
    return Output(navigateTo: navigateTo, questionList: preset.asDriver(onErrorJustReturn: []), presetTitles: presetTitles, presetQuestions: presetQuestions)
  }
}
