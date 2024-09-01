//
//  ProfileEditViewController.swift
//  matnamana
//
//  Created by 이진규 on 8/30/24.
// 키보드올라올때 화면 올라가게

import UIKit
import SnapKit

class ProfileEditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  private let profilePage: UILabel = {
    let label = UILabel()
    label.text = "나의 정보"
    label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
    return label
  }()

  private let profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "profile")
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 50
    imageView.clipsToBounds = true
    return imageView
  }()

  private let nameTextField: UITextField = {
    let textField = UITextField()
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.black.cgColor
    textField.layer.cornerRadius = 5
    textField.placeholder = "이름을 입력해주세요"
    return textField
  }()

  private let nickNameTextField: UITextField = {
    let textField = UITextField()
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.black.cgColor
    textField.layer.cornerRadius = 5
    textField.clearButtonMode = .always
    textField.placeholder = "닉네임을 입력해주세요"
    return textField
  }()

  private let introduceTextField: UITextField = {
    let textField = UITextField()
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.black.cgColor
    textField.layer.cornerRadius = 5
    textField.clearButtonMode = .always
    textField.placeholder = "자기소개를 입력해주새요"
    return textField
  }()

  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    return tableView
  }()

  private let userInfo = ["휴대번호", "이메일", "거주지", "생년월일", "직업", "회사명", "최종학력", "대학교"]

  override func viewDidLoad() {
    super.viewDidLoad()

    // 배경색 설정
    view.backgroundColor = .white

    // 네비게이션 바에 저장 버튼 추가
    setupNavigationBar()

    setupUI()
    setConstraints()
  }

  func setupNavigationBar() {
    // 왼쪽 상단에 저장 버튼 추가
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
  }

  @objc func saveButtonTapped() {
    // 이전 화면으로 돌아가기
    navigationController?.popViewController(animated: true)
  }

  func setupUI() {
    [
      profilePage,
      nameTextField,
      profileImageView,
      tableView,
      nameTextField,
      nickNameTextField,
      introduceTextField
    ].forEach { self.view.addSubview($0) }

    tableView.dataSource = self
    tableView.delegate = self
  }

  func setConstraints() {
    profilePage.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
      $0.leading.equalToSuperview().offset(24)
    }

    profileImageView.snp.makeConstraints {
      $0.top.equalTo(profilePage.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
      $0.width.height.equalTo(100)
    }

    nameTextField.snp.makeConstraints {
      $0.top.equalTo(profileImageView.snp.bottom).offset(30)
      $0.centerX.equalToSuperview()
    }
    nickNameTextField.snp.makeConstraints {
      $0.top.equalTo(nameTextField.snp.bottom).offset(8)
      $0.centerX.equalToSuperview()
    }
    introduceTextField.snp.makeConstraints {
      $0.top.equalTo(nickNameTextField.snp.bottom).offset(8)
      $0.centerX.equalToSuperview()
    }

    tableView.snp.makeConstraints {
      $0.top.equalTo(introduceTextField.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.bottom.equalToSuperview()
    }
  }

  // 테이블 뷰 데이터 소스 메서드
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return userInfo.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = userInfo[indexPath.row]

    let textField: UITextField = {
      let textField = UITextField()
      textField.clearButtonMode = .always
      textField.placeholder = "Value"
      return textField
    }()

    cell.contentView.addSubview(textField)
    textField.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(20)
      $0.centerY.equalToSuperview()
      $0.width.equalTo(200)
    }

    return cell
  }
}

