//
//  AcceptRequestViewModel.swift
//  matnamana
//
//  Created by pc on 9/9/24.
//

import Foundation

import RxCocoa
import RxSwift

class AcceptRequestViewModel {
  var selectedItems = BehaviorRelay<[IndexPath]>(value: [])
  let friendListView = FriendListView()
  func selectItem(at indexPath: IndexPath) {
    var currentItems = selectedItems.value
    currentItems.append(indexPath)
    selectedItems.accept(currentItems)
  }
  
  func removeItem(at indexPath: IndexPath) {
    var currentItems = selectedItems.value
    if let index = currentItems.firstIndex(of: indexPath) {
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
}
