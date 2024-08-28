//
//  UserSearchViewController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/28/24.
//

import UIKit

class SearchViewController: UIViewController {
  
  private var searchView = SearchView(frame: .zero)
  
  override func loadView() {
    searchView = SearchView(frame: UIScreen.main.bounds)
    self.view = searchView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.getData(urlString: "https://firestore.googleapis.com/v1/projects/matnamana-65c65/databases/(default)/documents/users")
  }
  }
}
