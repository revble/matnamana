//
//  FriendListViewModel.swift
//  matnamana
//
//  Created by 김윤홍 on 8/27/24.
//
// init 을생성해서 id값 nickName값을 넣어줘야할듯

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
      let db = Firestore.firestore()
      
      db.collection("users").document("abc").getDocument { (documentSnapshot, error) in
        guard let document = documentSnapshot, document.exists, error == nil else {
          print(error ?? "해당아이디 없음")
          return
        }
        
        do {
          let user = try document.data(as: User.self)
          let friends = user.friendList
          observer.onNext(friends)
          observer.onCompleted()
        } catch {
          observer.onError(error)
        }
      }
      return Disposables.create()
    }
  }
  
  func transform(input: Input) -> Output {
    let friendList = input.fetchFriends
      .flatMapLatest { [weak self] _  -> Observable<[User.Friend]> in
        guard let self = self else { return Observable.just([]) }
        return self.fetchFriendList()
      }
      .asDriver(onErrorJustReturn: [])
    
    return Output(friendList: friendList)
  }
}
