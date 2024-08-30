//
//  ProfileViewController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/29/24.
//

import UIKit

class ProfileViewController: UIViewController {
  
  private var profileView = ProfileView(frame: .zero)
  
  override func loadView() {
    profileView = ProfileView(frame: UIScreen.main.bounds)
    self.view = profileView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
  }
}
