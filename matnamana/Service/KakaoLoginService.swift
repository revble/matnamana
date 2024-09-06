//
//  KakaoLoginService.swift
//  matnamana
//
//  Created by pc on 9/2/24.
//

import Foundation

import FirebaseAuth
import KakaoSDKUser
import RxSwift

class KakaoLoginService {
  static let shared = KakaoLoginService()
  
  private let authResultSubject = PublishSubject<Bool>()
  
  func authResultObservable() -> Observable<Bool> {
    return authResultSubject.asObservable()
  }
  
  func kakaoLonginWithApp() {
    UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
      if let error = error {
        print(error)
        self?.authResultSubject.onNext(false)
      }
      else {
        print("loginWithKakaoTalk() success.")
        //do something
        _ = oauthToken
        self?.firebaseLoginWithKakao(oauthToken: oauthToken?.idToken)
        self?.authResultSubject.onNext(true)
      }
    }
  }
  
  func kakaoLoginWithAccount() {
    UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
      if let error = error {
        print(error)
        self?.authResultSubject.onNext(false)
      }
      else {
        print("loginWithKakaoAccount() success.")
        //do something
        _ = oauthToken
        self?.firebaseLoginWithKakao(oauthToken: oauthToken?.idToken)
        self?.authResultSubject.onNext(true)
      }
    }
  }
  
  func KakaoLogin() {
    // 카카오톡 실행 가능 여부 확인
    if (UserApi.isKakaoTalkLoginAvailable()) {
      // 카카오톡 앱으로 로그인 인증
      kakaoLonginWithApp()
    } else { // 카톡이 설치가 안 되어 있을 때
      // 카카오 계정으로 로그인
      kakaoLoginWithAccount()
    }
  }
  
  func kakaoUnlink() {
    UserApi.shared.unlink {(error) in
      if let error = error {
        print(error)
      }
      else {
        print("unlink() success.")
      }
    }
  }
  
  func getUserInfo() {
    UserApi.shared.me() {(user, error) in
      guard let user = user else { return }
      guard let kakaoAccount = user.kakaoAccount else { return }
      if let error = error {
        print(error)
      }
      else {
        print("me() success.")
        //do something
        let userName = kakaoAccount.name
        let userEmail = kakaoAccount.email
      }
    }
  }
  
  func firebaseLoginWithKakao(oauthToken: String?) {
    guard let token = oauthToken else { return }
    
    let credential = OAuthProvider.credential(withProviderID: "oidc.kakao", idToken: token, rawNonce: "")
    
    Auth.auth().signIn(with: credential) { (authResult, error) in
      if let error = error {
        print("Firebase Sign in with Kakao Failed: \(error.localizedDescription)")
      } else {
        print("Firebase Sign in with Kakao Success")
        // 로그인 성공 후 처리
      }
    }
  }
}
