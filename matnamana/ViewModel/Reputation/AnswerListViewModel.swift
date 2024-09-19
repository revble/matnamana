//
//  AnswerListViewModel.swift
//  matnamana
//
//  Created by pc on 9/19/24.
//

import Foundation

final class AnswerListViewModel {
  private let db = FirebaseManager.shared.db
  
  func fetchFriendList(requester: String, target: String) {
    let documentName = "\(requester)-\(target)"
    
    db.collection("reputationRequests").document(documentName)
      .getDocument { documentSnapshot, error in
        if let error {
        return
        }
        documentSnapshot?.data()
      }
  }
}
