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

final class FriendListViewModel: ViewModelType {
  
  struct Input {
    let fetchFriends: Observable<Void>
    let searchText: Observable<String>
  }
  
  struct Output {
    let friendList: Driver<[User.Friend]>
    let searchResult: Driver<Bool>
    let errorMessage: Driver<String>
  }
  
  private func fetchFriendList() -> Observable<[User.Friend]> {
    guard let loggedInUserId = UserDefaults.standard.string(forKey: "loggedInUserId") else { return .empty() }
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
  
  private func searchFriendInFirestore(by nickname: String) -> Observable<User?> {
    return Observable.create { observer in
      FirebaseManager.shared.getUserInfo(nickName: nickname) { user, error in
        if let error = error {
          observer.onError(error)
        } else {
          observer.onNext(user)
        }
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
  
  private func addFriend(nickName: String) -> Observable<Bool> {
    return Observable.create { observer in
      FirebaseManager.shared.addFriend(friendId: nickName,
                                       friendType: "친구",
                                       friendImage: "defaultImageURL") { success, error in
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
  
  func transform(input: Input) -> Output {
    let friendList = input.fetchFriends
      .flatMap { [weak self] _ -> Observable<[User.Friend]> in
        guard let self else { return Observable.just([]) }
        return self.fetchFriendList()
      }
      .asDriver(onErrorJustReturn: [])
    
    let searchResult = input.searchText
      .flatMap { [weak self] nickname -> Observable<Bool> in
        guard let self else { return Observable.just(false) }
        return self.searchFriendInFirestore(by: nickname)
          .flatMap { user -> Observable<Bool> in
            if user != nil {
              return Observable.just(true)
            } else {
              return self.addFriend(nickName: nickname)
            }
          }
      }
      .asDriver(onErrorJustReturn: false)
    
    let errorMessage = input.searchText
      .flatMap { nickname -> Observable<String> in
        return self.searchFriendInFirestore(by: nickname)
          .flatMap { user -> Observable<String> in
            if user == nil {
              return Observable.just("해당 닉네임의 사용자가 없습니다.")
            } else {
              return Observable.empty()
            }
          }
      }
      .asDriver(onErrorJustReturn: "")
    
    return Output(friendList: friendList,
                  searchResult: searchResult,
                  errorMessage: errorMessage)
  }
}