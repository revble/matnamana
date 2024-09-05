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



final class LoginViewModel: ViewModelType {

  struct Input {
    let loggedInAppel: Observable<Bool>
  }
  
  struct Output {
    let isDuplicate: Observable<Bool>
  }

  private let db = FirebaseManager.shared.db
  
//  func perfomAppleLogin() -> Observable<Void> {
//    return Observable.create { observer in
//      AppleLoginService.shared.startSignInWithAppleFlow { result in
//        switch result {
//        case .success:
//          observer.onNext(())
//        case .failure(let error):
//          observer.onError(error)
//        }
//        observer.onCompleted()
//      }
//      return Disposables.create()
//    }
//  }
  
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
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
  
  func transform(input: Input) -> Output {
//    let appleLoginResult = input.loginButtonTap
//      .flatMap { [weak self] _ -> Observable<Void> in
//        guard let self = self else {
//          return .empty()
//        }
//        return self.perfomAppleLogin()
//      }
    let isDuplicate = input.loggedInAppel
      .flatMap { [weak self] _ -> Observable<Bool> in
        guard let self = self else {
          return .empty()
        }
        return self.checkUidDuplicate()
      }
    return Output(isDuplicate: isDuplicate)
  }
}
