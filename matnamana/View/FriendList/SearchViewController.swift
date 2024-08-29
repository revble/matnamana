//
//  UserSearchViewController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/28/24.
//

import UIKit

import FirebaseCore
import FirebaseFirestore

class SearchViewController: UIViewController, UISearchBarDelegate {
  
  private var searchView = SearchView(frame: .zero)
  let db = Firestore.firestore()
  
  override func loadView() {
    searchView = SearchView(frame: UIScreen.main.bounds)
    self.view = searchView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchView.searchBar.delegate = self
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let text = searchView.searchBar.text {
      db.collection("users").document(text).getDocument { (snapshot, error) in
        guard let document = snapshot, document.exists, error == nil else {
          print("그런 사람 없음")
          return
        }
        if let data = document.data() {
          print(data)
        }
      }
    }
    searchBar.resignFirstResponder()
  }
}
