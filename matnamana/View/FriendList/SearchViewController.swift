//
//  UserSearchViewController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/28/24.
//

import UIKit

import FirebaseCore
import FirebaseFirestore
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
  
  private var searchView = SearchView(frame: .zero)
  private let disposeBag = DisposeBag()
  
  override func loadView() {
    searchView = SearchView(frame: UIScreen.main.bounds)
    self.view = searchView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    searchView.searchBar.rx.searchButtonClicked
      .subscribe(onNext: {
        print("검색눌림")
        self.searchView.searchBar.resignFirstResponder()
      }).disposed(by: disposeBag)
  }
  
//  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//    if let text = searchView.searchBar.text {
//      db.collection("users").document(text).getDocument { (snapshot, error) in
//        guard let document = snapshot, document.exists, error == nil else {
//          print("그런 사람 없음")
//          return
//        }
//        self.present(ProfileViewController(), animated: true)
//        if let data = document.data() {
//          print(data)
//        }
//      }
//    }
//    searchBar.resignFirstResponder()
//  }
}
