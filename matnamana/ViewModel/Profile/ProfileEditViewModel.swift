//
//  ProfileEditViewModel.swift
//  matnamana
//
//  Created by 이진규 on 9/2/24.

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
    let currentUserInfo: Observable<User.Info>  // Firebase에서 가져온 사용자 정보를 반환하는 Observable 추가
  }

  // Firebase에서 사용자 정보를 불러오는 메서드 추가
  private func fetchProfileData() -> Observable<User.Info> {
    return Observable.create { observer in
      guard let loggedInUserId = UserDefaults.standard.string(forKey: "loggedInUserId") else {
        observer.onError(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID not found"]))
        return Disposables.create()
      }

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

  // 입력을 받아 사용자 정보 저장 및 업데이트하는 메서드
  func transform(input: Input) -> Output {
    let saveResult = input.saveTap
      .withLatestFrom(Observable.combineLatest(input.nameText, input.nicknameText, input.shortDescriptionText, input.userInfoTexts, input.profileImageUrl))  // 이미지 URL 포함
      .flatMapLatest { [weak self] (name, nickName, shortDescription, userInfo, profileImageUrl) -> Observable<Bool> in
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
          nickName: nickName,
          birth: userInfo["생년월일"] ?? "",
          university: userInfo["대학교"] ?? "",
          companyName: userInfo["회사명"] ?? ""
        )

        guard let loggedInUserId = UserDefaults.standard.string(forKey: "loggedInUserId") else {
          return Observable.just(false)
        }

        let user = User(info: info, preset: [], friendList: [], userId: loggedInUserId)

        return self.saveUserData(user: user)
      }
      .asDriver(onErrorJustReturn: false)

    // Firebase에서 사용자 정보를 불러오는 Observable
    let profileData = fetchProfileData()

    return Output(saveResult: saveResult, currentUserInfo: profileData)
  }

  // Firebase에 사용자 데이터를 저장하는 메서드
  private func saveUserData(user: User) -> Observable<Bool> {
    return Observable.create { observer in
      FirebaseManager.shared.addUser(user: user)
      observer.onNext(true)
      observer.onCompleted()
      return Disposables.create()
    }
  }
}
