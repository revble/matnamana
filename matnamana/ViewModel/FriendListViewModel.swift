//
//  FriendListViewModel.swift
//  matnamana
//
//  Created by 김윤홍 on 8/27/24.
//

import Foundation

import RxSwift

class FriendListViewModel {
  
  let disposeBag = DisposeBag()
  let urlString = "https://firestore.googleapis.com/v1/projects/matnamana-65c65/databases/(default)/documents/users"
  
  func getData(urlString: String) {
    guard let url = URL(string: urlString) else {
      return
    }
    return NetworkManager.shared.dataFetch(url: url)
      .subscribe(onSuccess: { (user: User)  in
        print("userFEtch\(user)")
      }, onFailure: { error in
        print("error\(error)")
      }).disposed(by: disposeBag)
  }
}
