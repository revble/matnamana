//
//  LoginView.swift
//  matnamana
//
//  Created by pc on 8/28/24.
//

import UIKit

import SnapKit
import Then

final class LoginView: BaseView {
  
  private let logo = UIImageView().then {
    $0.image = UIImage(named: "MatnamanaLogo")
  }
  
  private let goodMeeting = UILabel().then {
    $0.text = "좋은 만남은"
    $0.font = UIFont.systemFont(ofSize: 35, weight: .bold)
  }
  
  private let goodQuestion = UILabel().then {
    $0.text = "좋은 질문으로부터"
    $0.font = UIFont.systemFont(ofSize: 35, weight: .bold)
  }
  
  private let quicklyReferenceCheck = UILabel().then {
    $0.text = "가장 빠르고 신뢰있는 평판조회서비스"
    $0.textColor = .gray
    $0.font = UIFont.systemFont(ofSize: 15)
  }
  
  private let matnamana = UILabel().then {
    $0.text = "맞나만나"
    $0.textColor = .gray
    $0.font = UIFont.systemFont(ofSize: 15)
  }
  
  let loginButton = UIButton().then {
    $0.setTitle("Apple로 로그인", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.backgroundColor = .black
    $0.layer.cornerRadius = 10
  }
  
  let kakaoLoginButton = UIButton().then {
    $0.setImage(UIImage(named: "kakaoLogin"), for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.backgroundColor = .black
    $0.layer.cornerRadius = 10
  }
  
  override func configureUI() {
    self.backgroundColor = .white
    [
      logo,
      goodMeeting,
      goodQuestion,
      quicklyReferenceCheck,
      matnamana,
      loginButton,
      kakaoLoginButton
    ].forEach { self.addSubview($0) }
  }
  
  override func setConstraints() {
    logo.snp.makeConstraints {
      $0.top.equalToSuperview().offset(50)
      $0.centerX.equalToSuperview()
      $0.width.height.equalTo(300)
    }
    
    goodMeeting.snp.makeConstraints {
      $0.top.equalTo(logo.snp.bottom)
      $0.centerX.equalToSuperview()
    }
    
    goodQuestion.snp.makeConstraints {
      $0.top.equalTo(goodMeeting.snp.bottom).offset(10)
      $0.centerX.equalToSuperview()
    }
    
    quicklyReferenceCheck.snp.makeConstraints {
      $0.top.equalTo(goodQuestion.snp.bottom).offset(10)
      $0.centerX.equalToSuperview()
    }
    
    matnamana.snp.makeConstraints {
      $0.top.equalTo(quicklyReferenceCheck.snp.bottom).offset(8)
      $0.centerX.equalToSuperview()
    }
    
    loginButton.snp.makeConstraints {
      $0.bottom.equalToSuperview().inset(200)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(160)
      $0.height.equalTo(35)
    }
    
    kakaoLoginButton.snp.makeConstraints {
      $0.bottom.equalToSuperview().inset(150)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(160)
      $0.height.equalTo(35)
    }
  }
}
