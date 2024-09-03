//
//  KakaoLoginService.swift
//  matnamana
//
//  Created by pc on 9/2/24.
//

import Foundation

import KakaoSDKUser

class KakaoLoginService {
  static let shared = KakaoLoginService()
  
  func kakaoLonginWithApp() {
    UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
      if let error = error {
        print(error)
      }
      else {
        print("loginWithKakaoTalk() success.")
        
        //do something
        _ = oauthToken
      }
    }
  }
  
  func kakaoLoginWithAccount() {
    
    UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
      if let error = error {
        print(error)
      }
      else {
        print("loginWithKakaoAccount() success.")
        
        //do something
        _ = oauthToken
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
        
        print("이름: \(userName)")
        print("이메일: \(userEmail)")
      }
    }
  }
  
}
