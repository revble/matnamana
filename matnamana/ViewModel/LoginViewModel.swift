//
//  FriendListViewModel.swift
//  matnamana
//
//  Created by 김윤홍 on 8/27/24.
//

import Foundation

import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import RxSwift
import RxCocoa

final class LoginViewModel {
  private let db = FirebaseManager.shared.db
  
  func checkUidDuplicate() -> Observable<Bool> {
    return Observable.create { [weak self] observer in
      guard let self = self else {
        observer.onCompleted()
        return Disposables.create()
      }
      
      guard let user = Auth.auth().currentUser else {
        observer.onCompleted()
        return Disposables.create()
      }
      
      let documentRef = self.db.collection("users").document(user.uid)
      print(user.uid)
      documentRef.getDocument { document, error in
        if let error = error {
          observer.onError(error)
          return
        }
        
        if let document = document, document.exists {
          print("가입된 사용자")
          observer.onNext(true)
        } else {
          print("가입되지 않은 사용자")
          observer.onNext(false)
        }
      }
      return Disposables.create()
    }
  }
}
