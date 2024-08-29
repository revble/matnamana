//
//  FriendListViewModel.swift
//  matnamana
//
//  Created by 김윤홍 on 8/27/24.
//
// init 을생성해서 id값 nickName값을 넣어줘야할듯, searchBar rxCocoa, 

import Foundation

import FirebaseCore
import FirebaseFirestore
import RxSwift
import RxCocoa

protocol ViewModelType {
  associatedtype Input
  associatedtype Output
  
  func transform(input: Input) -> Output
}

final class FriendListViewModel: ViewModelType {
  
  struct Input {
    let fetchFriends: Observable<Void>
  }
  
  struct Output {
    let friendList: Driver<[User.Friend]>
  }
  
  private let disposeBag = DisposeBag()
  
  private func fetchFriendList() -> Observable<[User.Friend]> {
    return Observable.create { observer in
      FirebaseManager.shared.readUser(documentId: "userId_123") { user, error in
        if let error = error {
          observer.onError(error)
        } else if let user = user {
          observer.onNext(user.friendList)
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
    let friendList = input.fetchFriends
      .flatMap { [weak self] _  -> Observable<[User.Friend]> in
        guard let self = self else { return Observable.just([]) }
        return self.fetchFriendList()
      }
      .asDriver(onErrorJustReturn: [])
    
    return Output(friendList: friendList)
  }
}
