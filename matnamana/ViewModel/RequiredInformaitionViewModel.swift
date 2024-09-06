
//
//  Created by pc on 8/30/24.
//

import Foundation

import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import RxSwift


final class RequiredInfoViewModel {

  private let disposeBag = DisposeBag()
  private let db = FirebaseManager.shared.db

  let isNicknameDuplicate = PublishSubject<Bool>()


  func checNicknameDuplicate(nickname: String) {
    db.collection("users").whereField("info.nickName",
                                      isEqualTo: nickname).getDocuments { [weak self] querySnapshot, error in
      guard let self = self else { return }
      if let error = error {
        print("error")
      }
      if let querySnapshot = querySnapshot, !querySnapshot.documents.isEmpty {
        print("중복된 닉네임")
        self.isNicknameDuplicate.onNext(true)
      } else {
        print("중복되지 않음")
        self.isNicknameDuplicate.onNext(false)
      }
    }
  }

  func saveLoginState(userId: String) {
    UserDefaults.standard.set(true, forKey: "isLoggedIn")
    UserDefaults.standard.set(userId, forKey: "loggedInUserId")
    print(UserDefaults.standard.bool(forKey: "isLoggedIn"))
    print(UserDefaults.standard.string(forKey: "loggedInUserId"))
  }

  func makeUserInformation(name: String, nickName: String, completion: @escaping (User) -> Void ) {
    guard let appleUser = Auth.auth().currentUser else { return }
    let user = User(
      info: User.Info(
        career: "",
        education: "",
        email: "",
        location: "",
        name: name,
        phoneNumber: "",
        shortDescription: "",
        profileImage: "",
        nickName: nickName,
        birth: "",
        university: "",
        companyName: ""
      ),
      preset: [],
      friendList: [],
      userId: appleUser.uid
    )
    FirebaseManager.shared.addUser(user: user)
    completion(user)
  }
}
