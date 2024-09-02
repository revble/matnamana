//
//  ProfileEditViewModel.swift
//  matnamana
//
//  Created by 이진규 on 9/2/24.
//

//import Foundation
//import FirebaseFirestore
//import RxSwift
//import RxCocoa
//
//class ProfileEditViewModel {
//
//    private let db = Firestore.firestore()
//    private let disposeBag = DisposeBag()
//
//    struct Input {
//        let saveTap: Observable<Void>
//        let nameText: Observable<String>
//        let nicknameText: Observable<String>
//        let shortDescriptionText: Observable<String>
//        let userInfoTexts: Observable<[String: String]>
//    }
//
//    struct Output {
//        let saveResult: Driver<Bool>
//    }
//
//    func transform(input: Input) -> Output {
//        let saveResult = input.saveTap
//            .withLatestFrom(Observable.combineLatest(input.nameText, input.nicknameText, input.shortDescriptionText, input.userInfoTexts))
//            .flatMapLatest { [weak self] (name, nickname, shortDescription, userInfo) -> Observable<Bool> in
//                guard let self = self else { return Observable.just(false) }
//
//                let userData: [String: Any] = [
//                    "name": name,
//                    "nickname": nickname,
//                    "shortDescription": shortDescription,
//                    "details": userInfo
//                ]
//
//                return self.saveUserData(userData: userData)
//            }
//            .asDriver(onErrorJustReturn: false)
//
//        return Output(saveResult: saveResult)
//    }
//
//    private func saveUserData(userData: [String: Any]) -> Observable<Bool> {
//        return Observable.create { observer in
//            self.db.collection("users").document("user_id_456").setData(userData) { error in
//                if let error = error {
//                    print("Error writing document: \(error)")
//                    observer.onNext(false)
//                } else {
//                    print("Document successfully written!")
//                    observer.onNext(true)
//                }
//                observer.onCompleted()
//            }
//            return Disposables.create()
//        }
//    }
//}
//import Foundation
//import FirebaseFirestore
//import RxSwift
//import RxCocoa
//
//class ProfileEditViewModel {
//
//    private let db = Firestore.firestore()
//    private let disposeBag = DisposeBag()
//
//    struct Input {
//        let saveTap: Observable<Void>
//        let nameText: Observable<String>
//        let nicknameText: Observable<String>
//        let shortDescriptionText: Observable<String>
//        let userInfoTexts: Observable<[String: String]>
//    }
//
//    struct Output {
//        let saveResult: Driver<Bool>
//    }
//
//    func transform(input: Input) -> Output {
//        let saveResult = input.saveTap
//            .withLatestFrom(Observable.combineLatest(input.nameText, input.nicknameText, input.shortDescriptionText, input.userInfoTexts))
//            .flatMapLatest { [weak self] (name, nickname, shortDescription, userInfo) -> Observable<Bool> in
//                guard let self = self else { return Observable.just(false) }
//
//                // 'User.Info' 객체 생성
//                let userInfoObj = User.Info(
//                    career: userInfo["직업"] ?? "",
//                    education: userInfo["최종학력"] ?? "",
//                    email: userInfo["이메일"] ?? "",
//                    location: userInfo["거주지"] ?? "",
//                    name: name,
//                    phoneNumber: userInfo["휴대번호"] ?? "",
//                    shortDescription: shortDescription,
//                    profileImage: "profile_image_url",  // 예시로 고정된 URL, 실제로는 사용자 입력을 받아야 합니다.
//                    nickname: nickname
//                )
//
//                // 'User' 객체 생성
//                let user = User(
//                    info: userInfoObj,
//                    preset: [],  // 실제 데이터로 설정해야 합니다.
//                    friendList: [],  // 실제 데이터로 설정해야 합니다.
//                    userId: "user_id_456"
//                )
//
//                // Firestore에 'User' 데이터 저장
//                return self.saveUserData(user: user)
//            }
//            .asDriver(onErrorJustReturn: false)
//
//        return Output(saveResult: saveResult)
//    }
//
//    private func saveUserData(user: User) -> Observable<Bool> {
//        return Observable.create { observer in
//            FirebaseManager.shared.addUser(user: user)  // 올바른 'User' 객체 사용
//            observer.onNext(true)
//            observer.onCompleted()
//            return Disposables.create()
//        }
//    }
//}
//import Foundation
//import FirebaseFirestore
//import RxSwift
//import RxCocoa
//
//class ProfileEditViewModel {
//
//    private let db = Firestore.firestore()
//    private let disposeBag = DisposeBag()
//
//    struct Input {
//        let saveTap: Observable<Void>
//        let nameText: Observable<String>
//        let nicknameText: Observable<String>
//        let shortDescriptionText: Observable<String>
//        let userInfoTexts: Observable<[String: String]>
//    }
//
//    struct Output {
//        let saveResult: Driver<Bool>
//    }
//
//    func transform(input: Input) -> Output {
//        let saveResult = input.saveTap
//            .withLatestFrom(Observable.combineLatest(input.nameText, input.nicknameText, input.shortDescriptionText, input.userInfoTexts))
//            .flatMapLatest { [weak self] (name, nickname, shortDescription, userInfo) -> Observable<Bool> in
//                guard let self = self else { return Observable.just(false) }
//
//                let info = User.Info(
//                    career: userInfo["직업"] ?? "",
//                    education: userInfo["최종학력"] ?? "",
//                    email: userInfo["이메일"] ?? "",
//                    location: userInfo["거주지"] ?? "",
//                    name: name,
//                    phoneNumber: userInfo["휴대번호"] ?? "",
//                    shortDescription: shortDescription,
//                    profileImage: "profile_image_url",  // 실제로는 사용자의 프로필 이미지 URL 사용
//                    nickname: nickname
//                )
//
//                let user = User(info: info, preset: [], friendList: [], userId: "user_id_456")
//
//                return self.saveUserData(user: user)
//            }
//            .asDriver(onErrorJustReturn: false)
//
//        return Output(saveResult: saveResult)
//    }
//
//    private func saveUserData(user: User) -> Observable<Bool> {
//        return Observable.create { observer in
//            FirebaseManager.shared.addUser(user: user)
//            observer.onNext(true)
//            observer.onCompleted()
//            return Disposables.create()
//        }
//    }
//}
//import Foundation
//import FirebaseFirestore
//import RxSwift
//import RxCocoa
//
//class ProfileEditViewModel {
//
//    private let db = Firestore.firestore()
//    private let disposeBag = DisposeBag()
//
//    struct Input {
//        let saveTap: Observable<Void>
//        let nameText: Observable<String>
//        let nicknameText: Observable<String>
//        let shortDescriptionText: Observable<String>
//        let userInfoTexts: Observable<[String: String]>
//        let profileImageUrl: Observable<String>  // 이미지 URL을 받을 Observable 추가
//    }
//
//    struct Output {
//        let saveResult: Driver<Bool>
//    }
//
//    func transform(input: Input) -> Output {
//        let saveResult = input.saveTap
//            .withLatestFrom(Observable.combineLatest(input.nameText, input.nicknameText, input.shortDescriptionText, input.userInfoTexts, input.profileImageUrl))  // 이미지 URL 포함
//            .flatMapLatest { [weak self] (name, nickname, shortDescription, userInfo, profileImageUrl) -> Observable<Bool> in
//                guard let self = self else { return Observable.just(false) }
//
//                let info = User.Info(
//                    career: userInfo["직업"] ?? "",
//                    education: userInfo["최종학력"] ?? "",
//                    email: userInfo["이메일"] ?? "",
//                    location: userInfo["거주지"] ?? "",
//                    name: name,
//                    phoneNumber: userInfo["휴대번호"] ?? "",
//                    shortDescription: shortDescription,
//                    profileImage: profileImageUrl,  // 실제 프로필 이미지 URL 사용
//                    nickname: nickname
//                )
//
//                let user = User(info: info, preset: [], friendList: [], userId: "user_id_456")
//
//                return self.saveUserData(user: user)
//            }
//            .asDriver(onErrorJustReturn: false)
//
//        return Output(saveResult: saveResult)
//    }
//
//    private func saveUserData(user: User) -> Observable<Bool> {
//        return Observable.create { observer in
//            FirebaseManager.shared.addUser(user: user)
//            observer.onNext(true)
//            observer.onCompleted()
//            return Disposables.create()
//        }
//    }
//}
import Foundation
import FirebaseFirestore
import RxSwift
import RxCocoa

class ProfileEditViewModel {

    private let db = Firestore.firestore()
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
                    nickname: nickname
                )

                let user = User(info: info, preset: [], friendList: [], userId: "user_id_9812")

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
