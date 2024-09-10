//
//  ReputaionModel.swift
//  matnamana
//
//  Created by pc on 9/7/24.
//

import Foundation

import FirebaseCore
import FirebaseFirestore
import Kingfisher
import RxSwift
import RxCocoa

final class ReputaionViewModel {
  
  private let db = FirebaseManager.shared.db
  
  var receivedReputationDataRelay = BehaviorRelay(value: [(String, String)]())
  var myRequestedReputationDataRelay = BehaviorRelay(value: [(String, String)]())
  var reputationDataRelay = BehaviorRelay(value: [(String, String)]())
  
  func fetchRequestedReputation() {
    guard let userId = UserDefaults.standard.string(forKey: "loggedInUserId") else { return }
    db.collection("users").document(userId).getDocument { [weak self] document, error in
      if let error = error {
        print("Error getting document: \(error.localizedDescription)")
      } else {
        guard let self,
              let userNickName = document?.get("info.nickName") as? String
        else { return }
        print(userNickName)
        let query = db.collection("reputationRequests").whereField("targetId", isEqualTo: userNickName/*본인닉네임*/)
        query
          .getDocuments { [weak self] querySnapshot, error in
            guard let self else { return }
            if let error = error {
              print("error")
            } else {
              var reputationData: [(String, String)] = []
              for document in querySnapshot!.documents {
                self.db.collection("reputationRequests").document(document.documentID).getDocument { documentSnapshot, error in
                  if let error = error {
                    print("error")
                  } else {
                    guard let requesterId = documentSnapshot?.get("requesterId") as? String else { return }
                    print("requesterId: \(requesterId)")
                    self.db.collection("users").document(requesterId).getDocument { requesterIdDoc, error in
                      if let error = error {
                        print("error")
                      } else {
                        guard
                          let profileImage = requesterIdDoc?.get("info.profileImage") as? String,
                          let userNickName = requesterIdDoc?.get("info.nickName") as? String
                        else { return }
                        print("profileImage: \(profileImage)")
                        reputationData.append((profileImage, userNickName))
                        self.receivedReputationDataRelay.accept(reputationData)
                      }
                    }
                  }
                }
              }
            }
          }
      }
    }
  }
  
  func fetchMyRequestReputation() {
    guard let userId = UserDefaults.standard.string(forKey: "loggedInUserId") else { return }
    db.collection("reputationRequests").document(userId).getDocument { [weak self] document, error in
      if let error = error {
        print("error")
      } else {
        guard let self,
              let userNickName = document?.get("targetId") as? String
        else { return }
        var myRequestData: [(String, String)] = []
        myRequestData.append(("",userNickName))
        self.myRequestedReputationDataRelay.accept(myRequestData)
      }
    }
  }
}





