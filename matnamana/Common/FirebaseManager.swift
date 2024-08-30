//
//  NetworkManager.swift
//  matnamana
//
//  Created by 김윤홍 on 8/28/24.
//

import FirebaseCore
import FirebaseFirestore
import RxSwift
import RxCocoa

class FirebaseManager {
  
  static let shared = FirebaseManager()
  
  let db = Firestore.firestore()
  
  func addUser(user: User) {
    let userData: [String: Any] = [
      "userId": user.userId,
      "info": [
        "career": user.info.career,
        "education": user.info.education,
        "email": user.info.email,
        "location": user.info.location,
        "name": user.info.name,
        "phoneNumber": user.info.phoneNumber,
        "shortDescription": user.info.shortDescription,
        "profileImage": user.info.profileImage,
        "nickName": user.info.nickName
      ],
      "preset": user.preset.map { preset in
        [
          "presetTitle": preset.presetTitle,
          "indice": preset.indice
        ]
      },
      "friendList": user.friendList.map { friend in
        [
          "nickname": friend.nickname,
          "type": friend.type.rawValue,
          "friendId": friend.friendId
        ]
      }
    ]
    
    db.collection("users").document(user.userId).setData(userData) { error in
      if let error = error {
        print(error)
      }
    }
  }
  
  func addReputationRequest(request: ReputationRequest) {
    let requestData: [String: Any] = [
      "requestId": request.requestId,
      "requesterId": request.requesterId,
      "targetId": request.targetId,
      "questionList": request.questionList.map { question in
        [
          "contentType": question.contentType.rawValue,
          "contentDescription": question.contentDescription
        ]
      },
      "status": request.status.rawValue,
      "selectedFriends": request.selectedFriends.map { friend in
        [
          "nickname": friend.nickname,
          "type": friend.type.rawValue,
          "friendId": friend.friendId
        ]
      }
    ]
    
    db.collection("reputationRequests").document(request.requestId).setData(requestData) { error in
      if let error = error {
        print(error)
      }
    }
  }
  
  func addQuestion(question: Question) {
    let questionData: [String: Any] = [
      "questionId": question.questionId,
      "contents": question.contents.map { content in
        [
          "contentType": content.contentType.rawValue,
          "contentDescription": content.contentDescription
        ]
      }
    ]
    
    db.collection("questions").document(question.questionId).setData(questionData) { error in
      if let error = error {
        print(error)
      }
    }
  }
  
  func addAnswer(answer: Answer) {
    let answerData: [String: Any] = [
      "answerId": answer.answerId,
      "requestId": answer.requestId,
      "questionId": answer.questionId,
      "responderId": answer.responderId,
      "answerText": answer.answerText,
      "createdAt": Timestamp(date: answer.createdAt)
    ]
    
    db.collection("answers").document(answer.answerId).setData(answerData) { error in
      if let error = error {
        print(error)
      }
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
        completion(user, nil)
      } catch {
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
}
