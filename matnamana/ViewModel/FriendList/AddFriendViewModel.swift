//
//  addFriendViewModel.swift
//  matnamana
//
//  Created by 김윤홍 on 9/1/24.
//

import FirebaseCore
import FirebaseFirestore
import RxCocoa
import RxSwift

final class AddFriendViewModel: ViewModelType {
  
  struct Input {
    let addFriend: Observable<[String]>
  }
  
  struct Output {
    let addFriendResult: Driver<Bool>
  }
  
  func transform(input: Input) -> Output {
    let addFriendResult = input.addFriend
      .flatMap { [weak self] friend -> Observable<Bool> in
        guard let self = self else { return .just(false) }
        return self.addFriend(friendId: friend[0], friendType: friend[1], friendImage: friend[2])
      }
      .asDriver(onErrorJustReturn: false)
    
    return Output(addFriendResult: addFriendResult)
  }
  
  private func addFriend(friendId: String,
                         friendType: String,
                         friendImage: String) -> Observable<Bool> {
    return Observable.create { observer in
      FirebaseManager.shared.addFriend(friendId: friendId,
                                       friendType: friendType,
                                       friendImage: friendImage) { success, error in
        if let error = error {
          observer.onError(error)
        } else {
          observer.onNext(success)
        }
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
}


