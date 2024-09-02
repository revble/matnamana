//
//  ProfileController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/23/24.
// 키보드올라올때 화면 올라가게

//import UIKit
//
//import SnapKit
//
//class ProfileController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//
//  // MARK: - UI Components
//
//  private let profilePage: UILabel = {
//    let label = UILabel()
//    label.text = "나의 정보"
//    label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
//    return label
//  }()
//
//  private let profileImageView: UIImageView = {
//    let imageView = UIImageView()
//    imageView.image = UIImage(named: "profile")
//    imageView.contentMode = .scaleAspectFill
//    imageView.layer.cornerRadius = 50
//    imageView.clipsToBounds = true
//    return imageView
//  }()
//
//  private let nameLabel: UILabel = {
//    let label = UILabel()
//    label.text = "김민지 (나이: 31살)"
//    label.textAlignment = .center
//    return label
//  }()
//
//  private let nickNameLabel: UILabel = {
//    let label = UILabel()
//    label.text = "닉네임을 입력해주세요"
//    label.textAlignment = .center
//    return label
//  }()
//  private let introduceLabel: UILabel = {
//    let label = UILabel()
//    label.layer.borderWidth = 1.0
//    label.text = "자기소개를 입력해주세요"
//    label.textAlignment = .center
//    return label
//  }()
//
//  private let tableView: UITableView = {
//    let tableView = UITableView()
//    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//    return tableView
//  }()
//
//  private let editButton: UIButton = {
//    let button = UIButton(type: .system)
//    button.setTitle("수정", for: .normal)
//    button.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
//    return button
//  }()
//
//  // MARK: - Data
//
//  private let userInfo = ["휴대번호", "이메일", "거주지", "생년월일", "직업", "회사명", "최종학력", "대학교"]
//  private let userValues = ["010-1234-5678", "e.mail", "지역", "0000-00-00", "직업", "회사", "최종학력", "__대학교"]
//
//  // MARK: - Lifecycle
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    setupUI()
//    setConstraints()
//  }
//
//  // MARK: - Setup Methods
//
//  func setupUI() {
//      [
//          profilePage,
//          nameLabel,
//          profileImageView,
//          tableView,
//          nickNameLabel,
//          editButton,
//          introduceLabel
//      ].forEach { self.view.addSubview($0) }
//
//
//    tableView.dataSource = self
//    tableView.delegate = self
//  }
//
//  private func setConstraints() {
//    profilePage.snp.makeConstraints {
//      $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
//      $0.leading.equalToSuperview().offset(24)
//    }
//
//    profileImageView.snp.makeConstraints {
//      $0.top.equalTo(profilePage.snp.bottom).offset(20)
//      $0.centerX.equalToSuperview()
//      $0.width.height.equalTo(100)
//    }
//
//    nameLabel.snp.makeConstraints {
//      $0.top.equalTo(profileImageView.snp.bottom).offset(30)
//      $0.centerX.equalToSuperview()
//    }
//    nickNameLabel.snp.makeConstraints {
//      $0.top.equalTo(nameLabel.snp.bottom).offset(8)
//      $0.centerX.equalToSuperview()
//    }
//    introduceLabel.snp.makeConstraints {
//      $0.top.equalTo(nickNameLabel.snp.bottom).offset(8)
//      $0.centerX.equalToSuperview()
//    }
//
//    tableView.snp.makeConstraints {
//      $0.top.equalTo(introduceLabel.snp.bottom).offset(20)
//      $0.leading.trailing.equalToSuperview().inset(20)
//      $0.bottom.equalToSuperview()
//    }
//
//    editButton.snp.makeConstraints {
//      $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
//      $0.trailing.equalToSuperview().inset(24)
//    }
//  }
//
//  // MARK: - Actions
//
//  @objc private func editProfile() {
//    let editVC = ProfileEditViewController()
//    navigationController?.pushViewController(editVC, animated: true)
//  }
//
//  // MARK: - UITableViewDataSource
//
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return userInfo.count
//  }
//
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//    cell.textLabel?.text = userInfo[indexPath.row]
//
//    let valueLabel = UILabel()
//    valueLabel.text = userValues[indexPath.row]
//    valueLabel.textAlignment = .right
//    valueLabel.textColor = .gray
//
//    cell.contentView.addSubview(valueLabel)
//    valueLabel.snp.makeConstraints {
//      $0.trailing.equalToSuperview().inset(20)
//      $0.centerY.equalToSuperview()
//    }
//
//    return cell
//  }
//}
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ProfileController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  // MARK: - UI Components

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

  private let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "이름"
    label.textAlignment = .center
    return label
  }()

  private let nickNameLabel: UILabel = {
    let label = UILabel()
    label.text = "닉네임"
    label.layer.borderColor = UIColor.lightGray.cgColor
    label.layer.borderWidth = 1.0
    label.textAlignment = .center
    return label
  }()

  private let introduceLabel: UILabel = {
    let label = UILabel()
    label.layer.borderWidth = 1.0
    label.layer.borderColor = UIColor.lightGray.cgColor
    label.text = "자기소개"
    label.textAlignment = .center
    return label
  }()

  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    return tableView
  }()

  private let editButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("수정", for: .normal)
    button.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
    return button
  }()

  // MARK: - Data

  private let userInfoKeys = ["휴대번호", "이메일", "거주지", "생년월일", "직업", "회사명", "최종학력", "대학교"]
  private var userValues = ["", "", "", "", "", "", "", ""]  // Firestore에서 불러온 값을 저장할 배열

  private let disposeBag = DisposeBag()
  private let viewModel = ProfileViewModel()

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setConstraints()
    bindViewModel()
  }

  // MARK: - Setup Methods

  func setupUI() {
    [
      profilePage,
      nameLabel,
      profileImageView,
      tableView,
      nickNameLabel,
      editButton,
      introduceLabel
    ].forEach { self.view.addSubview($0) }

    tableView.dataSource = self
    tableView.delegate = self
  }

  private func setConstraints() {
    profilePage.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
      $0.leading.equalToSuperview().offset(24)
    }

    profileImageView.snp.makeConstraints {
      $0.top.equalTo(profilePage.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
      $0.width.height.equalTo(100)
    }

    nameLabel.snp.makeConstraints {
      $0.top.equalTo(profileImageView.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(20) // 새 제약 조건 추가
    }

    nickNameLabel.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(8)
      $0.centerX.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(20) // 새 제약 조건 추가
    }

    introduceLabel.snp.makeConstraints {
      $0.top.equalTo(nickNameLabel.snp.bottom).offset(8)
      $0.centerX.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(20) // 새 제약 조건 추가
    }

    tableView.snp.makeConstraints {
      $0.top.equalTo(introduceLabel.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.bottom.equalToSuperview()
    }

    editButton.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
      $0.trailing.equalToSuperview().inset(24)
    }
  }

  // MARK: - Actions

  @objc private func editProfile() {
    let editVC = ProfileEditViewController()
    navigationController?.pushViewController(editVC, animated: true)
  }

  // MARK: - UITableViewDataSource

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return userInfoKeys.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = userInfoKeys[indexPath.row]

    let valueLabel = UILabel()
    valueLabel.text = userValues[indexPath.row]
    valueLabel.textAlignment = .right
    valueLabel.textColor = .gray

    cell.contentView.addSubview(valueLabel)
    valueLabel.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(20)
      $0.centerY.equalToSuperview()
    }

    return cell
  }

  // MARK: - ViewModel Binding

  private func bindViewModel() {
    let input = ProfileViewModel.Input(fetchProfile: Observable.just(()))
    let output = viewModel.transform(input: input)

    output.profileData
      .drive(onNext: { [weak self] profile in
        self?.nameLabel.text = profile.name
        self?.nickNameLabel.text = profile.nickname
        self?.introduceLabel.text = profile.shortDescription
        self?.profileImageView.loadImage(from: profile.profileImage)

        // TableView 데이터 업데이트
        self?.userValues = [
          profile.phoneNumber,
          profile.email,
          profile.location,
          "",  // 생년월일
          profile.career,
          "",  // 회사명
          profile.education,
          ""   // 대학교
        ]
        self?.tableView.reloadData()
      })
      .disposed(by: disposeBag)
  }
}

extension UIImageView {
  func loadImage(from urlString: String) {
    guard let url = URL(string: urlString) else { return }
    DispatchQueue.global().async {
      if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
        DispatchQueue.main.async {
          self.image = image
        }
      }
    }
  }
}
