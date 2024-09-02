//
//  ProfileViewModel.swift
//  matnamana
//
//  Created by 이진규 on 8/28/24.
//

//  ProfileController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/23/24.
//

//import FirebaseFirestore
//
//class ProfileController: UIViewController {
//    override func viewDidLoad() {
//      super.viewDidLoad()
//    }
//
//    func checkAndCreateDocuments(userId: String) {
//        let db = Firestore.firestore()
//
//        // 'users' 컬렉션에서 문서 가져오기
//        db.collection("users").document(userId).getDocument { snapshot, error in
//            if let error = error {
//                print("Error fetching document: \(error)")
//                return
//            }
//            guard snapshot?.exists == false else { return } // Check if document exists
//            let batch = db.batch()
//            let userRef = db.collection("users").document(userId)
//
//            batch.setData([
//                "name": "KYU",
//                "MBTI": "ENTJ"
//            ], forDocument: userRef)
//
//            // 배치 커밋
//            batch.commit { error in
//                if let error = error {
//                    print("Error writing batch: \(error)")
//                } else {
//                    print("Batch write succeeded.")
//                }
//            }
//            // 데이터 커밋 후 추가 로그 출력
//            print("Attempted to write to Firestore.")
//        }
//    }
//}

//import UIKit
//import FirebaseCore
//import FirebaseFirestore
//
//class ProfileController: UIViewController {
//    let db = Firestore.firestore()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        addDocumentWithAutoID()
//    }
//
//    func addDocumentWithAutoID() {
//        // 자동으로 생성된 ID로 'users' 컬렉션에 새 문서 추가
//        db.collection("users").addDocument(data: [
//            "name": "KYU",
//            "MBTI": "ENTJ"
//        ]) { error in
//            if let error = error {
//                print("Error adding document: \(error.localizedDescription)")
//            } else {
//                print("Document successfully added with auto-generated ID!")
//            }
//        }
//    }
//}
//
//class ProfileController: UIViewController {
//    let db = Firestore.firestore()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        addDocumentWithAutoID()
//    }
//
//    func addDocumentWithAutoID() {
//        // 자동으로 생성된 ID로 'users' 컬렉션에 새 문서 추가
//        db.collection("users").addDocument(data: [
//            "name": "KYU",
//            "MBTI": "ENTJ"
//        ]) { error in
//            if let error = error {
//                print("Error adding document: \(error.localizedDescription)")
//            } else {
//                print("Document successfully added with auto-generated ID!")
//            }
//        }
//    }
//}


//    override func viewDidLoad() {
////        super.viewDidLoad()
////
////        let userId = "uniqueUserId123" // 실제 사용자 ID로 변경
////        checkAndCreateDocuments(userId: userId)
//    }
//
//    func checkAndCreateDocuments(userId: String) {
//        let db = Firestore.firestore()
//
//        // 'users' 컬렉션에서 문서 가져오기
//        db.collection("users").document(userId).getDocument { snapshot, error in
//            if let error = error {
//                print("Error fetching document: \(error)")
//                return
//            }
//            guard snapshot?.exists == false else {
//                print("Document already exists.")
//                return
//            }
//
//            // 문서가 존재하지 않으면 새 문서 생성 (setData)
//            db.collection("users").document(userId).setData([
//                "name": "KYU",
//                "MBTI": "ENTJ"
//           ]) //{ error in
////                if let error = error {
////                    print("Error writing document: \(error)")
////                } else {
////                    print("Document successfully written!")
////                }
////            }
//        }
//    }
//}

//import UIKit
//
//import FirebaseFirestore
//
//class ProfileController: UIViewController {
//    let db = Firestore.firestore()
//
//    func saveUser(user: User, userID: String) {
//        do{
//            try db.collection("users").document(userID).setData(from: user) { error in
//                if let error = error {
//                    print("Error writing document: \(error)")
//                } else {
//                    print("Document successfully written!")
//                }
//            }
//        } catch let error {
//            print("Error encoding user: \(error)")
//        }
//    }
//
//    func loadUser(id: String) {
//        do {
//            try db.collection("users").document()
//        }
//    }
//
//    let user = User(info: User.Info(name: "KYU", MBTI: "ENTJ"), preset: [User.PresetQuestion(presetTitle: "j1", indice: [1,2,3,])], friendList: [User.Friend(nickname: "JJIN", type: .collegue)])
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    saveUser(user: user, userID: "LEE")
//    }
//}

// User 구조체가 Codable을 채택해야 Firestore에서 setData(from:) 사용 가능
//struct User: Codable {
//    struct Info: Codable {
//        let mbti: String
//        let career: String
//        let ed   ucation: String
//        let email: String
//        let location: String
//        let name: String
//        let phoneNumber: String
//        let shortDescription: String
//        let profileImage: String
//    }
//
//    struct PresetQuestion: Codable {
//        let presetTitle: String
//        let indice: [Int]
//    }
//
//    struct Friend: Codable {
//        let nickname: String
//        let type: FriendType
//    }
//
//    enum FriendType: String, Codable {
//        case family
//        case collegue
//        case friend
//    }
//
//    let info: Info
//    let preset: [PresetQuestion]
//    let friendList: [Friend]
//}
//import UIKit
//import FirebaseFirestore//데이터 업로드진짜
//
//
//class ProfileController: UIViewController {
//    let db = Firestore.firestore()
//
//    // Firestore에 User 객체 저장
//    func saveUser(user: User, userID: String) {
//        do {
//            try db.collection("users").document(userID).setData(from: user) { error in
//                if let error = error {
//                    print("Error writing document: \(error.localizedDescription)")
//                } else {
//                    print("Document successfully written!")
//                }
//            }
//        } catch let error {
//            print("Error encoding user: \(error.localizedDescription)")
//        }
//    }
//
//    // Firestore에서 User 객체 로드
//    func loadUser(id: String) {
//        let docRef = db.collection("users").document(id)
//        docRef.getDocument(as: User.self) { result in
//            switch result {
//            case .success(let user):
//                print("User loaded: \(user)")
//            case .failure(let error):
//                print("Error loading user: \(error.localizedDescription)")
//            }
//        }
//    }
//
//    // User 객체 생성 시 모든 필드 제공
//    let user = User(
//        info: User.Info(
//            mbti: "ENTJ",
//            career: "Developer",
//            education: "Bachelor",
//            email: "example@example.com",
//            location: "Seoul",
//            name: "KYU",
//            phoneNumber: "010-1234-5678",
//            shortDescription: "Swift Developer",
//            profileImage: "nill"
//        ),
//        preset: [
//            User.PresetQuestion(presetTitle: "j1", indice: [1, 2, 3])
//        ],
//        friendList: [
//            User.Friend(nickname: "JJIN", type: .collegue)
//        ]
//    )
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Firestore에 사용자 저장
//        saveUser(user: user, userID: "LEE")
//        // 사용자 로드
//        loadUser(id: "LEE")
//    }
//}
//
//import UIKit
//import FirebaseStorage
//
//class ProfileController: UIViewController {
//
//    let storage = Storage.storage() // Firebase Storage 인스턴스 생성
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        if let image = UIImage(named: "profile") {
//            upLoadImage(img: image) // 원하는 이미지 업로드
//        }
//    }
//
//    func upLoadImage(img: UIImage) {
//        if let data = img.jpegData(compressionQuality: 0.8) { // 이미지 데이터를 JPEG로 변환
//            let filePath = "profile"
//            let metaData = StorageMetadata()
//            metaData.contentType = "image/png" // 이미지 타입 설정
//            storage.reference().child(filePath).putData(data, metadata: metaData) { metaData, error in
//                if let error = error { // 실패 처리
//                    print(error.localizedDescription)
//                    return
//                }
//                print("성공") // 성공 처리
//            }
//        }
//    }
//}
import Foundation
import FirebaseFirestore
import RxSwift
import RxCocoa

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
            let documentId = "user_id_456"
            FirebaseManager.shared.readUser(documentId: documentId) { user, error in
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
            .flatMapLatest { [weak self] _ -> Observable<User.Info> in
                guard let self = self else { return Observable.just(User.Info.empty) }
                return self.fetchProfileData()
            }
            .asDriver(onErrorJustReturn: User.Info.empty)

        return Output(profileData: profileData)
    }
}

extension User.Info {
    static var empty: User.Info {
        return User.Info(career: "", education: "", email: "", location: "", name: "", phoneNumber: "", shortDescription: "", profileImage: "", nickname: "")
    }
}
