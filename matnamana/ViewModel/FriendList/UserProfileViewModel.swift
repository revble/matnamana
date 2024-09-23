//
//  ProfileViewModel.swift
//  matnamana
//
//  Created by 김윤홍 on 9/1/24.
//

import FirebaseCore
import FirebaseFirestore
import RxCocoa
import RxSwift

final class UserProfileViewModel: ViewModelType {
  
  struct Input {
    let fetchUser: Observable<Void>
    let nickName: String
  }
  
  struct Output {
    let userInfo: Driver<User.Info>
    let userInfoWithName: Driver<User.Info>
  }
  
  func transform(input: Input) -> Output {
    let userInfo = input.fetchUser
      .flatMap { _ in
        self.fetchUserInfo(nickName: input.nickName)
      }
      .asDriver(onErrorDriveWith: .empty())
    
    let userInfoWithName = input.fetchUser
      .flatMap { _ in
        self.fetchUserInfoWithName(name: input.nickName)
      }
      .asDriver(onErrorDriveWith: .empty())
    return Output(userInfo: userInfo, userInfoWithName: userInfoWithName)
  }
  
  private func fetchUserInfo(nickName: String) -> Observable<User.Info> {
    return Observable.create { observer in
      FirebaseManager.shared.getUserInfo(nickName: nickName) { user, error in
        if let user = user {
          observer.onNext(user.info)
        } else if let error = error {
          observer.onError(error)
        }
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
  
  private func fetchUserInfoWithName(name: String) -> Observable<User.Info> {
    return Observable.create { observer in
      FirebaseManager.shared.getUserInfoWithName(name: name) { user, error in
        if let user = user {
          observer.onNext(user.info)
        } else if let error = error {
          observer.onError(error)
        }
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
}
