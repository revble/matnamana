//
//  SearchViewModel.swift
//  matnamana
//
//  Created by 김윤홍 on 8/29/24.
//

import Foundation

import FirebaseCore
import FirebaseFirestore
import RxSwift
import RxCocoa

class SearchViewModel: ViewModelType {
  
  struct Input {
    let searchData: Observable<String>
  }
  
  struct Output {
    let searchResult: Driver<User?>
  }
  
  func transform(input: Input) -> Output {
    let searchResult = input.searchData
      .flatMapLatest { [weak self] data -> Observable<User?> in
        guard let self = self else {
          return Observable.just(nil)
        }
        return self.searchUser(by: data)
      }
      .asDriver(onErrorJustReturn: nil)
    return Output(searchResult: searchResult)
  }
  
  private func searchUser(by nickName: String) -> Observable<User?> {
    return Observable.create { observer in
      FirebaseManager.shared.db.collection("users")
        .whereField("info.nickName", isEqualTo: nickName)
        .getDocuments { (querySnapshot, error) in
          if let error = error {
            observer.onError(error)
          } else {
            if let document = querySnapshot?.documents.first {
              let user = try? document.data(as: User.self)
              observer.onNext(user)
            } else {
              observer.onNext(nil)
            }
            observer.onCompleted()
          }
        }
      return Disposables.create()
    }
  }
}
