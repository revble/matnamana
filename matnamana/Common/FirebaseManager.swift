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
  
  enum CollectionName: String {
    case user = "users"
    case reputationRequest = "reputationRequests"
    case question = "questions"
    case answer = "answers"
    
    var title: Any {
      switch self {
      case .user: return User.self
      case .reputationRequest: return ReputationRequest.self
      case .question: return Question.self
      case .answer: return Answer.self
      }
    }
  }
  
  func addData<T: Codable>(to collectionName: CollectionName, data: T, documentId: String) {
    
    if let dataDictionary = data.asDictionary {
      db.collection(collectionName.rawValue).document(documentId).setData(dataDictionary) { error in
        if let error = error {
          print("\(collectionName.rawValue) 추가 실패: \(error.localizedDescription)")
        } else {
          print("\(collectionName.rawValue) 추가 성공")
        }
      }
    } else {
      print("\(collectionName.rawValue) 데이터 변환 실패")
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
  
  func getQuestionList(documentId: String, completion: @escaping (Question?, Error?) -> Void) {
    db.collection("questions").document("questionId_789").getDocument { (documentSnapshot, error) in
      guard let document = documentSnapshot, document.exists, error == nil else {
        completion(nil, error)
        return
      }
      do {
        let question = try document.data(as: Question.self)
        print(question)
        completion(question, nil)
      } catch {
        print(error)
        completion(nil, error)
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
