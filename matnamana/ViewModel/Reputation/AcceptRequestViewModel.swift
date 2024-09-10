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
  
  func sendData() {
    print(selectedItems.value)
    
    let nickName = currentname.value
    print(nickName)
    
    db.collection("users").whereField("info.nickName", isEqualTo: nickName)
      .getDocuments { [weak self] querySnapshot, error in
        if let error = error {
          print("error")
        } else {
          guard let self else { return }
          for uId in querySnapshot!.documents {
            db.collection("reputationRequests").document(uId.documentID)
              .updateData([
                "selectedFriends": selectedItems.value
              ])
          }
        }
      }
  }
}
