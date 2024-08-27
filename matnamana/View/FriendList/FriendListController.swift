//
//  FriendListController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/23/24.
//

import UIKit

class FriendListController: UIViewController {
  
  private var friendListView = FriendListView(frame: .zero)
  
  override func loadView() {
    friendListView = FriendListView(frame: UIScreen.main.bounds)
    self.view = friendListView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
