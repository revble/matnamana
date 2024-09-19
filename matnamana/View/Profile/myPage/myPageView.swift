////
////  myPageView.swift
////  matnamana
////
////  Created by 이진규 on 9/13/24.
////

import UIKit
import SnapKit
import Then

final class MyPageView: BaseView {

  // MARK: - UI Components

  let myPageButton = UIButton(type: .system).then {
    var configuration = UIButton.Configuration.filled()
    configuration.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 35, bottom: 25, trailing: 35)
    configuration.baseBackgroundColor = .clear // 기본 배경색 제거
    configuration.background.cornerRadius = 16 // border-radius: 16px

    $0.configuration = configuration

    // 테두리와 그림자 설정 (변경된 색상 적용)
    $0.layer.cornerRadius = 16
    $0.layer.borderWidth = 1 // 테두리 두께
    $0.layer.borderColor = UIColor.lightGray.cgColor // 연한 회색 테두리
    $0.layer.shadowColor = UIColor.black.cgColor
    $0.layer.shadowOffset = CGSize(width: 0, height: 4) // box-shadow 오프셋
    $0.layer.shadowOpacity = 0.25 // box-shadow 투명도
    $0.layer.shadowRadius = 4 // box-shadow 반경
    $0.clipsToBounds = false // 그림자 보이도록 설정
  }

  let profileImageView = UIImageView().then {
    $0.image = UIImage(named: "profile")
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 50
    $0.layer.masksToBounds = true
  }

  let nameLabel = UILabel().then {
    $0.text = "김민지"
    $0.font = UIFont.boldSystemFont(ofSize: 18)
    $0.textAlignment = .center
  }

  let nicknameLabel = UILabel().then {
    $0.text = "(minji)"
    $0.font = UIFont.systemFont(ofSize: 14)
    $0.textColor = .gray
    $0.textAlignment = .center
  }

  let frindcount = UILabel().then {
    $0.text = "친구 0명"
    $0.font = UIFont.boldSystemFont(ofSize: 14)
    $0.textAlignment = .center

  }

  let introduceLabel = UILabel().then {
    $0.text = "공부하는 직장인"
    $0.font = UIFont.systemFont(ofSize: 14)
    $0.textAlignment = .center
  }

  let tableView = UITableView().then {
    $0.register(myPageCell.self, forCellReuseIdentifier: String(describing: myPageCell.self))
    $0.rowHeight = 48
  }

  // MARK: - Initialization

  override func configureUI() {
    [myPageButton, tableView].forEach { self.addSubview($0) }

    [profileImageView, nameLabel, nicknameLabel,frindcount, introduceLabel].forEach { myPageButton.addSubview($0) }
  }

  override func setConstraints() {
    // 프로필 버튼의 레이아웃 설정
    myPageButton.snp.makeConstraints {
      $0.top.equalTo(safeAreaLayoutGuide).offset(18)
      $0.leading.equalToSuperview().offset(UIScreen.main.bounds.width * 0.2)
      $0.trailing.equalToSuperview().offset(-UIScreen.main.bounds.width * 0.2)
      $0.height.equalToSuperview().multipliedBy(0.4)
    }

    // 이미지와 레이블의 레이아웃 설정
    profileImageView.snp.makeConstraints {
      $0.top.equalTo(myPageButton.snp.top).offset(20)
      $0.centerX.equalTo(myPageButton.snp.centerX)
      $0.width.height.equalTo(100)
    }

    nameLabel.snp.makeConstraints { $0.top.equalTo(profileImageView.snp.bottom).offset(10)
      $0.centerX.equalTo(myPageButton.snp.centerX)
    }

    nicknameLabel.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(5)
      $0.centerX.equalTo(myPageButton.snp.centerX)
    }

    frindcount.snp.makeConstraints {
      $0.top.equalTo(nicknameLabel.snp.bottom).offset(5)
      $0.centerX.equalTo(myPageButton.snp.centerX)
    }

    introduceLabel.snp.makeConstraints {
      $0.top.equalTo(frindcount.snp.bottom).offset(5)
      $0.centerX.equalTo(myPageButton.snp.centerX)
    }

    // 테이블 뷰의 레이아웃 설정
    tableView.snp.makeConstraints {
      $0.top.equalTo(myPageButton.snp.bottom).offset(30)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(self.safeAreaLayoutGuide)
    }
  }

  // MARK: - Override layoutSubviews to Apply Gradient

  override func layoutSubviews() {
    super.layoutSubviews()

    // 버튼에 그라데이션 설정
    applyGradientToButton(myPageButton)
  }

  // MARK: - Helper Methods

  private func applyGradientToButton(_ button: UIButton) {
    // 이미 존재하는 그라데이션 레이어 제거 (중복 방지)
    button.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }

    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [
      UIColor.white.cgColor,    // #FFF
      UIColor(red: 0.86, green: 0.86, blue: 0.86, alpha: 1).cgColor  // #DBDBDB
    ]
    gradientLayer.locations = [0.046, 1.2981] // 그라데이션의 위치 설정 (비율)
    gradientLayer.startPoint = CGPoint(x: 0.25, y: 0)  // 시작점 (왼쪽 상단 대각선)
    gradientLayer.endPoint = CGPoint(x: 0.75, y: 1)    // 끝점 (오른쪽 하단 대각선)
    gradientLayer.frame = button.bounds
    gradientLayer.cornerRadius = 16

    // 버튼의 레이어에 그라데이션 추가
    button.layer.insertSublayer(gradientLayer, at: 0)
  }
}
