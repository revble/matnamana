//
//  NetworkManager.swift
//  matnamana
//
//  Created by 김윤홍 on 8/28/24.
//

import FirebaseCore
import FirebaseFirestore

import RxCocoa
import RxSwift

class FirebaseManager {
  
  static let shared = FirebaseManager()
  let db = Firestore.firestore()
  
  func addUser(user: User) {
    if let userData = user.asDictionary {
      db.collection("users").document(user.userId).setData(userData) { error in
        if let error = error {
          print("user추가 실패 ID 오류: \(error)")
        }
      }
    } else {
      print("user추가 실패")
    }
  }
  
  func addReputationRequest(request: ReputationRequest) {
    if let requestData = request.asDictionary {
      db.collection("reputationRequests").document(request.requestId).setData(requestData) { error in
        if let error = error {
          print("reputation request추가 시류ㅐ: \(error)")
        }
      }
    } else {
      print("Reputationdictionary 변경 실패")
    }
  }
  
  func addQuestion(question: Question) {
    if let questionData = question.asDictionary {
      db.collection("questions").document(question.questionId).setData(questionData) { error in
        if let error = error {
          print("question추가 실패: \(error)")
        }
      }
    } else {
      print("Questiondictionary 변경 실패")
    }
  }
  
  func addAnswer(answer: Answer) {
    if let answerData = answer.asDictionary {
      db.collection("answers").document(answer.answerId).setData(answerData) { error in
        if let error = error {
          print("answer추가 실패: \(error)")
        }
      }
    } else {
      print("dictionary 변경 실패")
    }
  }
  
  func readUser(documentId: String, completion: @escaping (User?, Error?) -> Void) {
    db.collection("users").document(documentId).getDocument { (documentSnapshot, error) in
      guard let document = documentSnapshot, document.exists, error == nil else {
        completion(nil, error)
        return
      }
      do {
        let user = try document.data(as: User.self)
        print(user)
        completion(user, nil)
      } catch {
        print(error)
        completion(nil, error)
      }
    }
  }
  
  func searchUser(name: String) -> Observable<Bool> {
    return Observable.create { observer in
      self.db.collection("users").document(name).getDocument { (snapshot, error) in
        if let error = error {
          print(error)
          observer.onNext(false)
          observer.onCompleted()
          return
        }
        guard let document = snapshot, document.exists else {
          observer.onNext(false)
          observer.onCompleted()
          return
        }
        observer.onNext(true)
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
  
  func getUserInfo(nickName: String, completion: @escaping (User?, Error?) -> Void) {
    let query = db.collection("users").whereField("info.nickName", isEqualTo: nickName)
    query.getDocuments { (snapShot, error) in
      guard let snapshot = snapShot, error == nil else {
        completion(nil, error)
        return
      }
      
      if let document = snapshot.documents.first {
        do {
          let user = try document.data(as: User.self)
          completion(user, nil)
        } catch {
          completion(nil, error)
        }
      } else {
        completion(nil, nil)
      }
    }
  }
  
  func addFriend(friendId: String,
                 friendType: String,
                 friendImage: String,
                 completion: @escaping (Bool, Error?) -> Void) {
    guard let userId = UserDefaults.standard.string(forKey: "loggedInUserId") else {
      print("userID없음 확인안됨")
      return
    }
    guard let type = User.Friend.FriendType(rawValue: friendType) else { return }
    let newFriend = User.Friend(nickname: friendId,
                                type: type,
                                friendId: friendId, friendImage: friendImage)

    guard let friendData = newFriend.asDictionary else { return }

    let userDocument = Firestore.firestore().collection("users").document(userId)
    
    userDocument.updateData([
      "friendList": FieldValue.arrayUnion([friendData])
    ]) { error in
      if let error = error {
        completion(false, error)
      } else {
        completion(true, nil)
      }
    }
  }
}

extension Encodable {
  var asDictionary: [String: Any]? {
    guard let object = try? JSONEncoder().encode(self),
          let dictionary = try? JSONSerialization.jsonObject(with: object, options: []) 
            as? [String: Any] else {
      return nil
    }
    return dictionary
  }
}
