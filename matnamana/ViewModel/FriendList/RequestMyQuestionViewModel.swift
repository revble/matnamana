//
//  RequestMyQuestionViewModel.swift
//  matnamana
//
//  Created by 김윤홍 on 9/20/24.
//

import Foundation

import RxCocoa
import RxSwift

final class RequestMyQuestionViewModel: ViewModelType {
  
  struct Input {
    let fetchQuestions: Observable<Void>
  }
  
  struct Output {
    let questionList: Driver<[User.PresetQuestion]>
    let presetTitles: Driver<[String]>
    let presetQuestions: Driver<[User.PresetQuestion]>
  }
  
  func fetchQuestionList() -> Observable<[User.PresetQuestion]> {
    guard let id = UserDefaults.standard.string(forKey: "loggedInUserId") else { return Observable.just([]) }
    return Observable.create { observer in
      FirebaseManager.shared.getPresetList(documentId: id) { question, error in
        if let error = error {
          observer.onError(error)
        } else if let question = question {
          observer.onNext(question)
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
    
    let preset = input.fetchQuestions
      .flatMap { [weak self] _ -> Observable<[User.PresetQuestion]> in
        guard let self else { return Observable.just([]) }
        return self.fetchQuestionList()
      }
      .share(replay: 1)
    let presetTitles = preset
        .map { questions -> [String] in
            let titles = questions.map { $0.presetTitle }
            print("Preset titles: \(titles)")
            return titles
        }
        .asDriver(onErrorJustReturn: [])
    
    let presetQuestions = preset
          .asDriver(onErrorJustReturn: [])
    
    return Output(questionList: preset.asDriver(onErrorJustReturn: []), presetTitles: presetTitles, presetQuestions: presetQuestions)
  }
}
