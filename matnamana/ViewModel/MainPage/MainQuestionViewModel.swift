//
//  MainQuestionViewModel.swift
//  matnamana
//
//  Created by 김윤홍 on 9/7/24.
//

import RxSwift
import RxCocoa

final class MainQuestionViewModel {
  
  struct Input {
    let totalListButtonTap: Observable<Void>
  }
  
  struct Output {
    let moveTotalList: Driver<Void>
    let questionItems: Driver<[String]>
  }
  
  func transform(input: Input) -> Output {
    let moveTotalList = input.totalListButtonTap
      .asDriver(onErrorDriveWith: .empty())

    let questionItems = Observable.just([
      "IceBreaking", "BestFriend", "BestFamily", "BestMeeting", "BestCoworker"
    ]).asDriver(onErrorJustReturn: [])
    
    return Output(moveTotalList: moveTotalList, questionItems: questionItems)
  }
}
