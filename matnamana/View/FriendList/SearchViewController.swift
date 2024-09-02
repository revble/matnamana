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
  private let viewModel = SearchViewModel()
  
  override func loadView() {
    searchView = SearchView(frame: UIScreen.main.bounds)
    self.view = searchView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bind()
  }
  
  private func bind() {

    let searchData = searchView.searchBar.rx.searchButtonClicked
      .withLatestFrom(searchView.searchBar.rx.text.orEmpty)
      .asObservable()
    
    let input = SearchViewModel.Input(searchData: searchData)
    let output = viewModel.transform(input: input)
    
    output.searchResult
      .drive(onNext: { [weak self] user in
        self?.handleSearchResult(user)
      })
      .disposed(by: disposeBag)
  }
  
  private func handleSearchResult(_ user: User?) {
    if let user = user {
      let profileVC = ProfileViewController()
      profileVC.userInfo = user.info.nickName
      navigationController?.pushViewController(profileVC, animated: true)
      print("user: \(user.info.nickName)")
    }
  }
}
