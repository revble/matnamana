//
//  UserSearchViewController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/28/24.
//

import UIKit

final class SearchViewController: BaseViewController {
  
  private var searchView = SearchView(frame: .zero)
  private let viewModel = SearchViewModel()
  
  override func setupView() {
    searchView = SearchView(frame: UIScreen.main.bounds)
    self.view = searchView
  }

  override func setNavigation() {
    self.title = "검색"
  }
  
  override func bind() {
    let searchData = searchView.searchBar.rx.searchButtonClicked
      .withLatestFrom(searchView.searchBar.rx.text.orEmpty)
      .asObservable()
    
    let input = SearchViewModel.Input(searchData: searchData)
    let output = viewModel.transform(input: input)
    
    output.searchResult
      .drive(onNext: { [weak self] user in
        guard let self = self else { return }
        self.handleSearchResult(user)
      }).disposed(by: disposeBag)
  }
  
  private func handleSearchResult(_ user: User?) {
    if let user = user {
      let profileVC = ProfileViewController(userInfo: user.info.nickName)
      profileVC.userInfo = user.info.nickName
      navigationController?.pushViewController(profileVC, animated: true)
    } else {
      let alert = UIAlertController(title: "해당 닉네임의 사용자가 없습니다.",
                                    message: "",
                                    preferredStyle: .alert)
      
      let action = UIAlertAction(title: "확인",
                                 style: .default,
                                 handler: nil)
      alert.addAction(action)
      present(alert, animated: true, completion: nil)
    }
  }
}
