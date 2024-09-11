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
import RxCocoa
import RxSwift

final class ReputationViewModel: ViewModelType {
  
  struct Input {
    let refreshGesture: ControlProperty<CGPoint>
  }
  
  struct Output {
    let fetchTrigger: Observable<Void>
  }
  private let db = FirebaseManager.shared.db
  
  var friendReputationDataRelay = BehaviorRelay(value: [(String, String)]())
  var myRequestedReputationDataRelay = BehaviorRelay(value: [(String, String)]())
  var receivedReputationDataRelay = BehaviorRelay(value: [(String, String)]())
  
  func fetchReputationInfo() {
    guard let userId = UserDefaults.standard.string(forKey: "loggedInUserId") else { return }
    FirebaseManager.shared.fetchReputationInfo(userId: userId) { reputationRequests, error in
      if let error = error {
        print("error")
      }
      guard let reputationRequests else { return }
      
      var friendReputationData: [(String, String)] = []
      var myRequestedReputationData: [(String, String)] = []
      var receivedReputationData: [(String, String)] = []

      for reputationRequest in reputationRequests {
        
        guard let target = reputationRequest.target,
              let requester = reputationRequest.requester,
              let selectedFriends = reputationRequest.selectedFriends else { return }
        
        if userId == target.userId {
          let profileImage = requester.profileImage ?? ""
          let nickName = requester.nickName ?? ""
          receivedReputationData.append((profileImage, nickName))
        }
        
        if userId == requester.userId {
          let profileImage = target.profileImage ?? ""
          let nickName = target.nickName ?? ""
          myRequestedReputationData.append((profileImage, nickName))
        }
        
        if selectedFriends.contains(where: { $0.userId == userId }) {
          let profileImage = target.profileImage ?? ""
          let nickName = target.nickName ?? ""
          friendReputationData.append((profileImage, nickName))
        }

        self.friendReputationDataRelay.accept(friendReputationData)
        self.receivedReputationDataRelay.accept(receivedReputationData)
        self.myRequestedReputationDataRelay.accept(myRequestedReputationData)
      }
    }
  }
  
  func transform(input: Input) -> Output {
    
    let fetchTrigger = input.refreshGesture
      .filter { $0.y < -100 }
      .map { _ in () }
    
    return Output(fetchTrigger: fetchTrigger)
  }
  
}



