//
//import Foundation
//import RxCocoa
//import RxSwift
//import FirebaseFirestore
//
//protocol ProfileViewModelType {
//  associatedtype Input
//  associatedtype Output
//
//  func transform(input: Input) -> Output
//}
//
//final class ProfileViewModel: ProfileViewModelType {
//
//  struct Input {
//    let fetchProfile: Observable<Void>
//  }
//
//  struct Output {
//    let profileData: Driver<User.Info>
//    let userAge: Driver<String>  // 나이 데이터를 전달하기 위한 추가 Output
//  }
//
//  private let disposeBag = DisposeBag()
//
//  private func fetchProfileData() -> Observable<User.Info> {
//    return Observable.create { observer in
//      let loggedInUserId = UserDefaults.standard.string(forKey: "loggedInUserId")!
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
//  private func calculateAge(from birth: String) -> String {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyyMMdd"
//
//    guard let birthDate = dateFormatter.date(from: birth) else {
//        return "00"
//    }
//
//    let calendar = Calendar.current
//    let now = Date()
//    let ageComponents = calendar.dateComponents([.year], from: birthDate, to: now)
//
//    if let age = ageComponents.year {
//        return "\(age)"
//    } else {
//        return "00"
//    }
//  }
//
//  func transform(input: Input) -> Output {
//    let profileData = input.fetchProfile
//      .flatMap { [weak self] _ -> Observable<User.Info> in
//        guard let self = self else { return Observable.just(User.Info.empty) }
//        return self.fetchProfileData()
//      }
//      .asDriver(onErrorJustReturn: User.Info.empty)
//
//    // 나이 계산 로직 추가
//    let userAge = profileData
//      .map { [weak self] info -> String in
//        guard let self = self else { return "00" }
//        return self.calculateAge(from: info.birth)
//      }
//      .asDriver(onErrorJustReturn: "00")
//
//    return Output(profileData: profileData, userAge: userAge)
//  }
//}
//
//extension User.Info {
//  static var empty: User.Info {
//    return User.Info(career: "", education: "", email: "", location: "", name: "", phoneNumber: "", shortDescription: "", profileImage: "", nickName: "", birth: "", university: "", companyName: "")
//  }
//}
