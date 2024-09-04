//
//  FriendListViewModel.swift
//  matnamana
//
//  Created by 김윤홍 on 8/27/24.
//

import FirebaseCore
import FirebaseFirestore
import RxCocoa
import RxSwift

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
    let loggedInUserId = UserDefaults.standard.string(forKey: "loggedInUserId")!
    return Observable.create { observer in
      FirebaseManager.shared.readUser(documentId: loggedInUserId) { user, error in
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
