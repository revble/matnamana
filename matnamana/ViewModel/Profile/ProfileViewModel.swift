//  ProfileController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/23/24.
//
import Foundation

import RxCocoa
import RxSwift
import FirebaseFirestore

final class ProfileViewModel: ViewModelType {
  
  struct Input {
    let fetchProfile: Observable<Void>
  }
  
  struct Output {
    let profileData: Driver<User.Info>
    let userAge: Driver<String>
  }
  
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
  
  private func calculateAge(from birth: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"  // 올바른 형식 설정
    
    guard let birthDate = dateFormatter.date(from: birth) else { 
      return "00"  // 생년월일이 잘못된 형식일 경우 기본값 반환
    }
    
    let calendar = Calendar.current
    let now = Date()
    let ageComponents = calendar.dateComponents([.year], from: birthDate, to: now)  // 현재 날짜와 비교하여 나이 계산
    
    if let age = ageComponents.year {  // 년도 차이를 사용하여 나이 계산
      return "\(age)"
    } else {
      return "00"
    }
  }
  
  
  func transform(input: Input) -> Output {
    let profileData = input.fetchProfile
      .flatMap { [weak self] _ -> Observable<User.Info> in
        guard let self = self else { return Observable.just(User.Info.empty) }
        return self.fetchProfileData()
      }
      .asDriver(onErrorJustReturn: User.Info.empty)
    
    let userAge = profileData
      .map { [weak self] info -> String in
        guard let self = self else {return "00"}
        return self.calculateAge(from: info.birth)
      }
      .asDriver(onErrorJustReturn: "00")
    
    return Output(profileData: profileData, userAge: userAge)
  }
}

extension User.Info {
  static var empty: User.Info {
    return User.Info(career: "", education: "", email: "", location: "", name: "", phoneNumber: "", shortDescription: "", profileImage: "", nickName: "", birth: "", university: "", companyName: "")
  }
}
