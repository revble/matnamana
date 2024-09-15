//
//  myPageView.swift
//  matnamana
//
//  Created by 이진규 on 9/13/24.
//

import UIKit

import SnapKit
import Then

final class MyPageView: BaseView {

  let myPageButton = UIButton(configuration: .bordered()).then{
    $0.configuration?.baseBackgroundColor = .lightGray
    $0.layer.cornerRadius = 12
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }

  let profileImageView = UIImageView().then {
    $0.image = UIImage(named: "profile")
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 50
    $0.layer.masksToBounds = true
  }

  let nicknameLabel = UILabel().then {
    $0.text = "(minji)"
    $0.font = UIFont.systemFont(ofSize: 14)
    $0.textColor = .gray
    $0.textAlignment = .center
  }

  let nameLabel = UILabel().then {
    $0.text = "김민지"
    $0.font = UIFont.boldSystemFont(ofSize: 18)
    $0.textAlignment = .center
  }

  let introduceLabel = UILabel().then {
    $0.text = "공부하는 직장인"
    $0.font = UIFont.systemFont(ofSize: 14)
    $0.textColor = .darkGray
    $0.textAlignment = .center
  }

  let tableView = UITableView().then{
    $0.register(myPageCell.self,
                forCellReuseIdentifier: String(describing: myPageCell.self))
    $0.rowHeight = 38
  }

  override func configureUI() {
    [myPageButton,
     tableView
    ].forEach { self.addSubview($0) }

    [profileImageView, nameLabel, nicknameLabel, introduceLabel].forEach { myPageButton.addSubview($0) }
  }

  override func setConstraints() {
    // 프로필 버튼의 레이아웃 설정
    myPageButton.snp.makeConstraints {
      $0.top.equalTo(safeAreaLayoutGuide).offset(18) // 위에서 168 포인트 떨어지게 설정
      $0.leading.equalToSuperview().offset(76.5)
      $0.trailing.equalToSuperview().offset(-76.5)
      $0.width.equalTo(240)
      $0.height.equalTo(320)
    }

    // 이미지와 레이블의 레이아웃 설정
    profileImageView.snp.makeConstraints { make in
      make.top.equalTo(myPageButton.snp.top).offset(20)
      make.centerX.equalTo(myPageButton.snp.centerX)
      make.width.height.equalTo(100)
    }

    nameLabel.snp.makeConstraints { make in
      make.top.equalTo(profileImageView.snp.bottom).offset(10)
      make.centerX.equalTo(myPageButton.snp.centerX)
    }

    nicknameLabel.snp.makeConstraints { make in
      make.top.equalTo(nameLabel.snp.bottom).offset(5)
      make.centerX.equalTo(myPageButton.snp.centerX)
    }

    introduceLabel.snp.makeConstraints { make in
      make.top.equalTo(nicknameLabel.snp.bottom).offset(5)
      make.centerX.equalTo(myPageButton.snp.centerX)
    }

    // 테이블 뷰의 레이아웃 설정
    tableView.snp.makeConstraints {
      $0.top.equalTo(myPageButton.snp.bottom).offset(37)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview().offset(-49)
    }
  }
}
