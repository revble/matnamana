//  ProfileController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/23/24.
//
import Foundation

import RxCocoa
import RxSwift
import FirebaseFirestore


protocol ProfileViewModelType {
  associatedtype Input
  associatedtype Output
  
  func transform(input: Input) -> Output
}

final class ProfileViewModel: ProfileViewModelType {
  
  struct Input {
    let fetchProfile: Observable<Void>
  }
  
  struct Output {
    let profileData: Driver<User.Info>
  }
  
  private let disposeBag = DisposeBag()
  
  private func fetchProfileData() -> Observable<User.Info> {
    return Observable.create { observer in
      let loggedInUserId = UserDefaults.standard.string(forKey: "loggedInUserId")!
      FirebaseManager.shared.readUser(documentId: loggedInUserId) { user, error in
        if let error = error {
          observer.onError(error)
        } else if let user = user {
          observer.onNext(user.info)
          observer.onCompleted()
        } else {
          observer.onNext(User.Info.empty)
          observer.onCompleted()
        }
      }
      return Disposables.create()
    }
  }
  
  func transform(input: Input) -> Output {
    let profileData = input.fetchProfile
      .flatMap { [weak self] _ -> Observable<User.Info> in
        guard let self = self else { return Observable.just(User.Info.empty) }
        return self.fetchProfileData()
      }
      .asDriver(onErrorJustReturn: User.Info.empty)
    
    return Output(profileData: profileData)
  }
}

extension User.Info {
  static var empty: User.Info {
    return User.Info(career: "", education: "", email: "", location: "", name: "", phoneNumber: "", shortDescription: "", profileImage: "", nickName: "", birth: "", university: "", companyName: "")
  }
}
