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
    let totalButtonTap: Observable<Void>
    let coupleButtonTap: Observable<Void>
    let simpleMannamButtonTap: Observable<Void>
    let businessButtonTap: Observable<Void>
  }
  
  struct Output {
    let navigateTo: Observable<Destination>
  }
  
  enum Destination {
    case totalQuestion
    case coupleQuestion
    case simpleMannam
    case business
  }
  
  func transform(input: Input) -> Output {
    let navigateTo = Observable.merge(
      input.totalButtonTap.map { Destination.totalQuestion },
      input.coupleButtonTap.map { Destination.coupleQuestion },
      input.simpleMannamButtonTap.map { Destination.simpleMannam },
      input.businessButtonTap.map { Destination.business }
    )
    
    return Output(navigateTo: navigateTo)
  }
}
