//
//  LoginView.swift
//  matnamana
//
//  Created by pc on 8/28/24.
//

import UIKit
import SnapKit

class LoginView: UIView {
  
  private let logo: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage()
    imageView.backgroundColor = .yellow
    return imageView
  }()
  
  private let bigDescription: UILabel = {
    let label = UILabel()
    label.text = "좋은 만남은 좋은 질문으로부터"
    label.backgroundColor = .red
    label.numberOfLines = 2
    label.textAlignment = .left
    return label
  }()
  
  private let smallDescription: UILabel = {
    let label = UILabel()
    label.text = "가장 빠르고 신뢰있는 평판조회서비스 맞나만나"
    label.backgroundColor = .red
    label.numberOfLines = 2
    label.textAlignment = .left
    return label
  }()
  
  let loginButton: UIButton = {
    let button = UIButton()
    button.setTitle("Apple로 로그인", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .black
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    setConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  func configureUI() {
    self.backgroundColor = .white
    [
    logo,
    bigDescription,
    smallDescription,
    loginButton
    ].forEach { self.addSubview($0) }
  }
  
  func setConstraint() {
    logo.snp.makeConstraints {
      $0.top.equalToSuperview().offset(50)
      $0.centerX.equalToSuperview()
      $0.width.height.equalTo(300)
    }
    
    bigDescription.snp.makeConstraints {
      $0.top.equalTo(logo.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
      $0.width.lessThanOrEqualToSuperview().inset(20)
    }
    
    smallDescription.snp.makeConstraints {
      $0.top.equalTo(bigDescription.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
      $0.width.lessThanOrEqualToSuperview().inset(20)
    }
    
    loginButton.snp.makeConstraints {
      $0.bottom.equalToSuperview().inset(150)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(150)
      $0.height.equalTo(30)
    }
    
  }
  
}
