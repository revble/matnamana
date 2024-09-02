//
//  addFriendViewModel.swift
//  matnamana
//
//  Created by 김윤홍 on 9/1/24.
//

import FirebaseCore
import FirebaseFirestore
import RxSwift
import RxCocoa


final class addFriendViewModel: ViewModelType {
  
  struct Input {
    let addFriend: Observable<(String, String)>
    
  }
  
  struct Output {
    let addFriendResult: Driver<Bool>
  }
  
  private let disposeBag = DisposeBag()
  
  func transform(input: Input) -> Output {
    let addFriendResult = input.addFriend
      .flatMap { [weak self] friendId, friendType -> Observable<Bool> in
        guard let self = self else { return .just(false) }
        return self.addFriend(friendId: friendId, friendType: friendType)
      }
      .asDriver(onErrorJustReturn: false)
    
    return Output(addFriendResult: addFriendResult)
  }
  
  private func addFriend(friendId: String, friendType: String) -> Observable<Bool> {
    return Observable.create { observer in
      FirebaseManager.shared.addFriend(friendId: friendId, friendType: friendType) { success, error in
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


