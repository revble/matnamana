//
//  AcceptRequestViewModel.swift
//  matnamana
//
//  Created by pc on 9/9/24.
//

import Foundation

import RxCocoa
import RxSwift

final class AcceptRequestViewModel {
  
  init() {}
  
  var currentname = BehaviorRelay<String>(value: "")
  var selectedItems = BehaviorRelay<[String]>(value: [])
  
  private let db = FirebaseManager.shared.db
  
  private let reputationView = ReputationView()
  private let friendListView = FriendListView()
  
  func selectItem(selectedFriends: String) {
    var currentItems = selectedItems.value
    currentItems.append(selectedFriends)
    selectedItems.accept(currentItems)
  }
  
  func removeItem(at indexPath: IndexPath, selectedFriends: String) {
    var currentItems = selectedItems.value
    if let index = currentItems.firstIndex(of: selectedFriends) {
      currentItems.remove(at: index)
      selectedItems.accept(currentItems)
      friendListView.friendList.deselectRow(at: indexPath, animated: true)
    }
  }
  
  func removeFirstItem() {
    var currentItems = selectedItems.value
    currentItems.remove(at: 0)
    selectedItems.accept(currentItems)
  }
  
  func selectName(_ name: String) {
    currentname.accept(name)
    print(name)
  }
  
  func sendData(requester: String, target: String) {
    print(selectedItems.value)
    let documentId = "\(requester)-\(target)"
    var friendList: [User] = []
    
    let dispatchGroup = DispatchGroup()
    for selectedItem in selectedItems.value {
      print(selectedItem)
      dispatchGroup.enter()
      db.collection("users").whereField("info.nickName", isEqualTo: selectedItem)
        .getDocuments { querySnapshot, error in
          guard let querySnapshot,
                error == nil
          else { return }
          if let document = querySnapshot.documents.first {
            do {
              let user = try document.data(as: User.self)
              
              print(user)
              friendList.append(user)
            } catch {
              
            }
          }
          dispatchGroup.leave()
        }
      
    }
    dispatchGroup.notify(queue: .main) {
      self.db.collection("reputationRequests").document(documentId)
        .updateData([
          "selectedFriends": friendList.map { friend in
            [
              "nickName": friend.info.nickName,
              "profileImage": friend.info.profileImage,
              "userId": friend.userId
            ]
          },
          "selectedFriendsUserIds": friendList.map { $0.userId }
        ])
    }
  }
  
}
