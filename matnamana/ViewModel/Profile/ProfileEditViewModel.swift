//
//  ProfileEditViewModel.swift
//  matnamana
//
//  Created by 이진규 on 9/2/24.

import Foundation

import FirebaseFirestore
import RxCocoa
import RxSwift



final class ProfileEditViewModel: ViewModelType {

  //private let db = FirebaseManager.shared.db

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
  private func fetchProfileData() -> Observable<User> {
    return Observable.create { observer in
      guard let loggedInUserId = UserDefaults.standard.string(forKey: "loggedInUserId") else {
        observer.onError(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID not found"]))
        return Disposables.create()
      }

      FirebaseManager.shared.readUser(documentId: loggedInUserId) { user, error in
        if let error = error {
          observer.onError(error)
        } else if let user = user {
          observer.onNext(user)
          observer.onCompleted()
        } else {
          observer.onNext(User(info: .empty, preset: [], friendList: [], userId: loggedInUserId))
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
      .flatMap { [weak self] (name, nickName, shortDescription, userInfo, profileImageUrl) -> Observable<Bool> in
        guard let self = self else { return Observable.just(false) }

        return self.fetchProfileData()
          .flatMap { existingUser -> Observable<Bool> in
            // 기존의 User 객체를 받아와 필요한 필드만 업데이트
            let updatedInfo = User.Info(
              career: userInfo["직업"] ?? existingUser.info.career,
              education: userInfo["최종학력"] ?? existingUser.info.education,
              email: userInfo["이메일"] ?? existingUser.info.email,
              location: userInfo["거주지"] ?? existingUser.info.location,
              name: name,
              phoneNumber: userInfo["휴대번호"] ?? existingUser.info.phoneNumber,
              shortDescription: shortDescription,
              profileImage: profileImageUrl,
              nickName: nickName,
              birth: userInfo["생일"] ?? existingUser.info.birth,
              university: userInfo["대학교"] ?? existingUser.info.university,
              companyName: userInfo["회사"] ?? existingUser.info.companyName
            )

            // 기존 preset과 friendList를 유지
            let updatedUser = User(info: updatedInfo, preset: existingUser.preset, friendList: existingUser.friendList, userId: existingUser.userId)

            return self.saveUserData(user: updatedUser)
          }
      }
      .asDriver(onErrorJustReturn: false)

    // Firebase에서 사용자 정보를 불러오는 Observable
    let profileData = fetchProfileData().map { $0.info }

    return Output(saveResult: saveResult, currentUserInfo: profileData)
  }

  // Firebase에 사용자 데이터를 저장하는 메서드
  private func saveUserData(user: User) -> Observable<Bool> {
    return Observable.create { observer in
      FirebaseManager.shared.addData(to: .user, data: user, documentId: user.userId)
      observer.onNext(true)
      observer.onCompleted()
      return Disposables.create()
    }
  }
}

//  struct Input {
//    let saveTap: Observable<Void>
//    let nameText: Observable<String>
//    let nicknameText: Observable<String>
//    let shortDescriptionText: Observable<String>
//    let userInfoTexts: Observable<[String: String]>
//    let profileImageUrl: Observable<String>  // 이미지 URL을 받을 Observable 추가
//  }
//
//  struct Output {
//    let saveResult: Driver<Bool>
//    let currentUserInfo: Observable<User.Info>  // Firebase에서 가져온 사용자 정보를 반환하는 Observable 추가
//  }
//
//  // Firebase에서 사용자 정보를 불러오는 메서드 추가
//  private func fetchProfileData() -> Observable<User.Info> {
//    return Observable.create { observer in
//      guard let loggedInUserId = UserDefaults.standard.string(forKey: "loggedInUserId") else {
//        observer.onError(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID not found"]))
//        return Disposables.create()
//      }
//
//      FirebaseManager.shared.readUser(documentId: loggedInUserId) { user, error in
//        if let error = error {
//          observer.onError(error)
//        } else if let user = user {
//          observer.onNext(user.info)
//          observer.onCompleted()
//        } else {
//          observer.onNext(User.Info.empty)
//          observer.onCompleted()
//        }
//      }
//      return Disposables.create()
//    }
//  }
//
//  // 입력을 받아 사용자 정보 저장 및 업데이트하는 메서드
//  func transform(input: Input) -> Output {
//    let saveResult = input.saveTap
//      .withLatestFrom(Observable.combineLatest(input.nameText, input.nicknameText, input.shortDescriptionText, input.userInfoTexts, input.profileImageUrl))  // 이미지 URL 포함
//      .flatMap { [weak self] (name, nickName, shortDescription, userInfo, profileImageUrl) -> Observable<Bool> in
//        guard let self = self else { return Observable.just(false) }
//
//        let info = User.Info(
//          career: userInfo["직업"] ?? "",
//          education: userInfo["최종학력"] ?? "",
//          email: userInfo["이메일"] ?? "",
//          location: userInfo["거주지"] ?? "",
//          name: name,
//          phoneNumber: userInfo["휴대번호"] ?? "",
//          shortDescription: shortDescription,
//          profileImage: profileImageUrl,
//          nickName: nickName,
//          birth: userInfo["생일"] ?? "",
//          university: userInfo["대학교"] ?? "",
//          companyName:userInfo["회사"] ?? ""
//
//        )
//
//        guard let loggedInUserId = UserDefaults.standard.string(forKey: "loggedInUserId") else {
//          return Observable.just(false)
//        }
//
//        let user = User(info: info, preset: [], friendList: [], userId: loggedInUserId)
//
//        return self.saveUserData(user: user)
//      }
//      .asDriver(onErrorJustReturn: false)
//
//    // Firebase에서 사용자 정보를 불러오는 Observable
//    let profileData = fetchProfileData()
//
//    return Output(saveResult: saveResult, currentUserInfo: profileData)
//  }
//
//  // Firebase에 사용자 데이터를 저장하는 메서드
//  private func saveUserData(user: User) -> Observable<Bool> {
//    return Observable.create { observer in
////      FirebaseManager.shared.addUser(user: user)
//      observer.onNext(true)
//      observer.onCompleted()
//      return Disposables.create()
//    }
//  }
//}
