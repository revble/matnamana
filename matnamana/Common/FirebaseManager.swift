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

final class FirebaseManager {
  
  static let shared = FirebaseManager()
  private init() {}
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
                 status: String,
                 friendName: String,
                 targetId: String,
                 completion: @escaping (Bool, Error?) -> Void) {
    guard let userId = UserDefaults.standard.string(forKey: "loggedInUserId") else {
      print("userID없음 확인안됨")
      return
    }
    guard let type = User.Friend.FriendType(rawValue: friendType) else { return }
    let newFriend = User.Friend(name: friendName,
                                type: type,
                                friendId: friendId,
                                friendImage: friendImage,
                                status: .pending, targetId: targetId)
    guard let myName = UserDefaults.standard.string(forKey: "userName") else { return }
    guard let myNickName = UserDefaults.standard.string(forKey: "userNickName") else { return }
    
    let currentUser = User.Friend(name: myName,
                                  type: type,
                                  friendId: myNickName,
                                  friendImage: "",
                                  status: .pending,
                                  targetId: targetId)
    
    guard let friendData = newFriend.asDictionary else { return }
    guard let userData = currentUser.asDictionary else { return }
    
    let userDocument = db.collection("users").document(userId)
    let friendDocument = db.collection("users").whereField("info.nickName", isEqualTo: friendId)
    
    friendDocument.getDocuments { (snapshot, error) in
      
      guard let snapshot = snapshot, !snapshot.isEmpty else {
        completion(false, nil)
        return
      }
      
      if let document = snapshot.documents.first {
        let friendUUID = document.documentID
        
        let friendCollection = self.db.collection("users").document(friendUUID)
        
        friendCollection.updateData([
          "friendList": FieldValue.arrayUnion([userData])
        ]) { error in
          if let error = error {
            completion(false, error)
            return
          }
          
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
    }
  }
  
  func getQuestionList(documentId: String, completion: @escaping (Question?, Error?) -> Void) {
    db.collection("questions").document(documentId).getDocument { (documentSnapshot, error) in
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
  
  func updateFriendList(userId: String, newFriendList: [User.Friend], friendUserId: String, friendNewFriendList: [User.Friend], completion: @escaping (Bool, Error?) -> Void) {
    let userDocument = db.collection("users").document(userId)
    let friendDocument = db.collection("users").document(friendUserId)
    
    let friendListData = newFriendList.map { $0.asDictionary }
    let friendUserListData = friendNewFriendList.map { $0.asDictionary }
    
    let batch = db.batch()  // Firestore Batch 사용하여 두 문서 업데이트
    
    // 내 친구 목록 업데이트
    batch.updateData([
      "friendList": friendListData
    ], forDocument: userDocument)
    
    // 친구의 친구 목록 업데이트
    batch.updateData([
      "friendList": friendUserListData
    ], forDocument: friendDocument)
    
    batch.commit { error in
      if let error = error {
        print("Failed to update both friend lists: \(error.localizedDescription)")
        completion(false, error)
      } else {
        print("Successfully updated both friend lists.")
        completion(true, nil)
      }
    }
  }
  
  func getUserDocumentId(nickName: String, completion: @escaping (String?, Error?) -> Void) {
    let query = db.collection("users").whereField("info.nickName", isEqualTo: nickName)
    query.getDocuments { snapshot, error in
      if let error = error {
        completion(nil, error)
        return
      }
      
      if let document = snapshot?.documents.first {
        completion(document.documentID, nil)
      } else {
        completion(nil, nil)
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
