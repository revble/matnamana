//
//  ReputaionModel.swift
//  matnamana
//
//  Created by pc on 9/7/24.
//

import Foundation

import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Kingfisher
import RxSwift
import RxCocoa

class ReputaionViewModel {
  
  private let db = FirebaseManager.shared.db
  
  var reputationDataRelay = BehaviorRelay(value: [(String, String)]())
  
  func fetchRequestedReputation() {
    guard let userId = UserDefaults.standard.string(forKey: "loggedInUserId") else { return }
    print("userId: \(userId)")
    let query = db.collection("reputationRequests").whereField("targetId", isEqualTo: "jieun"/*본인닉네임*/)
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
                    self.reputationDataRelay.accept(reputationData)
                  }
                }
              }
            }
          }
        }
      }
  }
}
