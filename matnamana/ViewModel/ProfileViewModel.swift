//
//  ProfileViewModel.swift
//  matnamana
//
//  Created by 김윤홍 on 9/1/24.
//

import FirebaseCore
import FirebaseFirestore
import RxSwift
import RxCocoa

final class ProfileViewModel: ViewModelType {
  
  struct Input {
    let fetchUser: Observable<Void>
    let nickName: String
  }
  
  struct Output {
    let userInfo: Driver<User.Info>
  }
  
  private let disposeBag = DisposeBag()
  
  func transform(input: Input) -> Output {
    let userInfo = input.fetchUser
      .flatMap { _ in
        self.fetchUserInfo(nickName: input.nickName)
      }
      .asDriver(onErrorDriveWith: .empty())
    return Output(userInfo: userInfo)
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
}
