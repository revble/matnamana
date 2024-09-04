//
//  ProfileEditViewModel.swift
//  matnamana
//
//  Created by 이진규 on 9/2/24.
//


import Foundation

import FirebaseFirestore
import RxCocoa
import RxSwift

class ProfileEditViewModel {
  
  private let db = FirebaseManager.shared.db
  private let disposeBag = DisposeBag()
  
  struct Input {
    let saveTap: Observable<Void>
    let nameText: Observable<String>
    let nicknameText: Observable<String>
    let shortDescriptionText: Observable<String>
    let userInfoTexts: Observable<[String: String]>
    let profileImageUrl: Observable<String>  // 이미지 URL을 받을 Observable 추가
  }
  
  struct Output {
    let saveResult: Driver<Bool>
  }
  
  func transform(input: Input) -> Output {
    let saveResult = input.saveTap
      .withLatestFrom(Observable.combineLatest(input.nameText, input.nicknameText, input.shortDescriptionText, input.userInfoTexts, input.profileImageUrl))  // 이미지 URL 포함
      .flatMapLatest { [weak self] (name, nickname, shortDescription, userInfo, profileImageUrl) -> Observable<Bool> in
        guard let self = self else { return Observable.just(false) }
        
        let info = User.Info(
          career: userInfo["직업"] ?? "",
          education: userInfo["최종학력"] ?? "",
          email: userInfo["이메일"] ?? "",
          location: userInfo["거주지"] ?? "",
          name: name,
          phoneNumber: userInfo["휴대번호"] ?? "",
          shortDescription: shortDescription,
          profileImage: profileImageUrl,  // 실제 프로필 이미지 URL 사용
          nickName: nickname
        )
        
        guard let loggedInUserId = UserDefaults.standard.string(forKey: "loggedInUserId") else {
          return Observable.just(false)
        }
        
        let user = User(info: info, preset: [], friendList: [], userId: loggedInUserId)
        
        return self.saveUserData(user: user)
      }
      .asDriver(onErrorJustReturn: false)
    
    return Output(saveResult: saveResult)
  }
  
  private func saveUserData(user: User) -> Observable<Bool> {
    return Observable.create { observer in
      FirebaseManager.shared.addUser(user: user)
      observer.onNext(true)
      observer.onCompleted()
      return Disposables.create()
    }
  }
}
