//
//  ProfileEditViewController.swift
//  matnamana
//
//  Created by 이진규 on 8/30/24.
// 키보드올라올때 화면 올라가게

//import UIKit
//import SnapKit
//
//class ProfileEditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
//  private let nameTextField: UITextField = {
//    let textField = UITextField()
//    textField.layer.borderWidth = 1.0
//    textField.layer.borderColor = UIColor.black.cgColor
//    textField.layer.cornerRadius = 5
//    textField.placeholder = "이름을 입력해주세요"
//    return textField
//  }()
//
//  private let nickNameTextField: UITextField = {
//    let textField = UITextField()
//    textField.layer.borderWidth = 1.0
//    textField.layer.borderColor = UIColor.black.cgColor
//    textField.layer.cornerRadius = 5
//    textField.clearButtonMode = .always
//    textField.placeholder = "닉네임을 입력해주세요"
//    return textField
//  }()
//
//  private let introduceTextField: UITextField = {
//    let textField = UITextField()
//    textField.layer.borderWidth = 1.0
//    textField.layer.borderColor = UIColor.black.cgColor
//    textField.layer.cornerRadius = 5
//    textField.clearButtonMode = .always
//    textField.placeholder = "자기소개를 입력해주새요"
//    return textField
//  }()
//
//  private let tableView: UITableView = {
//    let tableView = UITableView()
//    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//    return tableView
//  }()
//
//  private let userInfo = ["휴대번호", "이메일", "거주지", "생년월일", "직업", "회사명", "최종학력", "대학교"]
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//
//    // 배경색 설정
//    view.backgroundColor = .white
//
//    // 네비게이션 바에 저장 버튼 추가
//    setupNavigationBar()
//
//    setupUI()
//    setConstraints()
//  }
//
//  func setupNavigationBar() {
//    // 왼쪽 상단에 저장 버튼 추가
//    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
//  }
//
//  @objc func saveButtonTapped() {
//    // 이전 화면으로 돌아가기
//    navigationController?.popViewController(animated: true)
//  }
//
//  func setupUI() {
//    [
//      profilePage,
//      nameTextField,
//      profileImageView,
//      tableView,
//      nameTextField,
//      nickNameTextField,
//      introduceTextField
//    ].forEach { self.view.addSubview($0) }
//
//    tableView.dataSource = self
//    tableView.delegate = self
//  }
//
//  func setConstraints() {
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
//    nameTextField.snp.makeConstraints {
//      $0.top.equalTo(profileImageView.snp.bottom).offset(30)
//      $0.centerX.equalToSuperview()
//    }
//    nickNameTextField.snp.makeConstraints {
//      $0.top.equalTo(nameTextField.snp.bottom).offset(8)
//      $0.centerX.equalToSuperview()
//    }
//    introduceTextField.snp.makeConstraints {
//      $0.top.equalTo(nickNameTextField.snp.bottom).offset(8)
//      $0.centerX.equalToSuperview()
//    }
//
//    tableView.snp.makeConstraints {
//      $0.top.equalTo(introduceTextField.snp.bottom).offset(20)
//      $0.leading.trailing.equalToSuperview().inset(20)
//      $0.bottom.equalToSuperview()
//    }
//  }
//
//  // 테이블 뷰 데이터 소스 메서드
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return userInfo.count
//  }
//
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//    cell.textLabel?.text = userInfo[indexPath.row]
//
//    let textField: UITextField = {
//      let textField = UITextField()
//      textField.clearButtonMode = .always
//      textField.placeholder = "Value"
//      return textField
//    }()
//
//    cell.contentView.addSubview(textField)
//    textField.snp.makeConstraints {
//      $0.trailing.equalToSuperview().inset(20)
//      $0.centerY.equalToSuperview()
//      $0.width.equalTo(200)
//    }
//
//    return cell
//  }
//}
//진짜
//import UIKit
//import SnapKit
//import RxSwift
//import RxCocoa
//
//class ProfileEditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//
//    // MARK: - UI Components
//
//    private let profilePage: UILabel = {
//        let label = UILabel()
//        label.text = "나의 정보"
//        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
//        return label
//    }()
//
//    private let profileImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "profile")
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 50
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//
//    private let nameTextField: UITextField = {
//        let textField = UITextField()
//        textField.layer.borderWidth = 1.0
//        textField.layer.borderColor = UIColor.black.cgColor
//        textField.layer.cornerRadius = 5
//        textField.placeholder = "이름을 입력해주세요"
//        return textField
//    }()
//
//    private let nickNameTextField: UITextField = {
//        let textField = UITextField()
//        textField.layer.borderWidth = 1.0
//        textField.layer.borderColor = UIColor.black.cgColor
//        textField.layer.cornerRadius = 5
//        textField.clearButtonMode = .always
//        textField.placeholder = "닉네임을 입력해주세요"
//        return textField
//    }()
//
//    private let introduceTextField: UITextField = {
//        let textField = UITextField()
//        textField.layer.borderWidth = 1.0
//        textField.layer.borderColor = UIColor.black.cgColor
//        textField.layer.cornerRadius = 5
//        textField.clearButtonMode = .always
//        textField.placeholder = "자기소개를 입력해주세요"
//        return textField
//    }()
//
//    private let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        return tableView
//    }()
//
//    private let userInfo = ["휴대번호", "이메일", "거주지", "생년월일", "직업", "회사명", "최종학력", "대학교"]
//    private let disposeBag = DisposeBag()
//    private let viewModel = ProfileEditViewModel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        setupNavigationBar()
//        setupUI()
//        setConstraints()
//        bindViewModel()
//    }
//
//    // MARK: - Setup Methods
//
//    private func setupUI() {
//        [profilePage, nameTextField, profileImageView, tableView, nickNameTextField, introduceTextField].forEach {
//            view.addSubview($0)
//        }
//
//        tableView.dataSource = self
//        tableView.delegate = self
//    }
//
//    private func setConstraints() {
//        profilePage.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
//            $0.leading.equalToSuperview().offset(24)
//        }
//
//        profileImageView.snp.makeConstraints {
//            $0.top.equalTo(profilePage.snp.bottom).offset(20)
//            $0.centerX.equalToSuperview()
//            $0.width.height.equalTo(100)
//        }
//
//        nameTextField.snp.makeConstraints {
//            $0.top.equalTo(profileImageView.snp.bottom).offset(30)
//            $0.centerX.equalToSuperview()
//        }
//
//        nickNameTextField.snp.makeConstraints {
//            $0.top.equalTo(nameTextField.snp.bottom).offset(8)
//            $0.centerX.equalToSuperview()
//        }
//
//        introduceTextField.snp.makeConstraints {
//            $0.top.equalTo(nickNameTextField.snp.bottom).offset(8)
//            $0.centerX.equalToSuperview()
//        }
//
//        tableView.snp.makeConstraints {
//            $0.top.equalTo(introduceTextField.snp.bottom).offset(20)
//            $0.leading.trailing.equalToSuperview().inset(20)
//            $0.bottom.equalToSuperview()
//        }
//    }
//
//    func setupNavigationBar() {
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
//    }
//
//    @objc func saveButtonTapped() {
//        // 저장 로직 호출
//        saveUserData()
//    }
//
//    private func saveUserData() {
//        // Firestore에 사용자 데이터 저장 로직 구현
//    }
//
//    // MARK: - UITableViewDataSource Methods
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return userInfo.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = userInfo[indexPath.row]
//
//        let textField: UITextField = {
//            let textField = UITextField()
//            textField.clearButtonMode = .always
//            textField.placeholder = "Value"
//            return textField
//        }()
//
//        cell.contentView.addSubview(textField)
//        textField.snp.makeConstraints {
//            $0.trailing.equalToSuperview().inset(20)
//            $0.centerY.equalToSuperview()
//            $0.width.equalTo(200)
//        }
//
//        return cell
//    }
//
//    // MARK: - ViewModel Binding
//
//    private func bindViewModel() {
//        let saveTap = navigationItem.leftBarButtonItem!.rx.tap.asObservable()
//        let nameText = nameTextField.rx.text.orEmpty.asObservable()
//        let nicknameText = nickNameTextField.rx.text.orEmpty.asObservable()
//        let shortDescriptionText = introduceTextField.rx.text.orEmpty.asObservable()
//
//        let userInfoTexts = Observable.just(userInfo).map { userInfo in
//            userInfo.reduce(into: [String: String]()) { result, key in
//                if let cell = self.tableView.cellForRow(at: IndexPath(row: userInfo.firstIndex(of: key)!, section: 0)),
//                   let textField = cell.contentView.subviews.compactMap({ $0 as? UITextField }).first {
//                    result[key] = textField.text ?? ""
//                }
//            }
//        }
//
//        let input = ProfileEditViewModel.Input(
//            saveTap: saveTap,
//            nameText: nameText,
//            nicknameText: nicknameText,
//            shortDescriptionText: shortDescriptionText,
//            userInfoTexts: userInfoTexts
//        )
//
//        let output = viewModel.transform(input: input)
//
//        output.saveResult
//            .drive(onNext: { [weak self] success in
//                if success {
//                    self?.navigationController?.popViewController(animated: true)
//                } else {
//                    print("Failed to save user data.")
//                }
//            })
//            .disposed(by: disposeBag)
//    }
//}
//import UIKit
//import SnapKit
//import RxSwift
//import RxCocoa
//import FirebaseFirestore
//
//class ProfileEditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//
//    // MARK: - UI Components
//
//    private let profilePage: UILabel = {
//        let label = UILabel()
//        label.text = "나의 정보"
//        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
//        return label
//    }()
//
//    private let profileImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "profile")
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 50
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//
//    private let nameTextField: UITextField = {
//        let textField = UITextField()
//        textField.layer.borderWidth = 1.0
//        textField.layer.borderColor = UIColor.black.cgColor
//        textField.layer.cornerRadius = 5
//        textField.placeholder = "이름을 입력해주세요"
//        return textField
//    }()
//
//    private let nickNameTextField: UITextField = {
//        let textField = UITextField()
//        textField.layer.borderWidth = 1.0
//        textField.layer.borderColor = UIColor.black.cgColor
//        textField.layer.cornerRadius = 5
//        textField.clearButtonMode = .always
//        textField.placeholder = "닉네임을 입력해주세요"
//        return textField
//    }()
//
//    private let introduceTextField: UITextField = {
//        let textField = UITextField()
//        textField.layer.borderWidth = 1.0
//        textField.layer.borderColor = UIColor.black.cgColor
//        textField.layer.cornerRadius = 5
//        textField.clearButtonMode = .always
//        textField.placeholder = "자기소개를 입력해주세요"
//        return textField
//    }()
//
//    private let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.rowHeight = UITableView.automaticDimension  // 자동 높이 사용
//        tableView.estimatedRowHeight = 44  // 기본 높이 설정
//        return tableView
//    }()
//
//    private let userInfo = ["휴대번호", "이메일", "거주지", "생년월일", "직업", "회사명", "최종학력", "대학교"]
//    private var userDetails: [String: String] = [:]  // 테이블뷰 데이터 저장
//    private let disposeBag = DisposeBag()
//    private let viewModel = ProfileEditViewModel()
//    private let db = Firestore.firestore()  // Firestore 인스턴스
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        setupNavigationBar()
//        setupUI()
//        setConstraints()
//        bindViewModel()
//    }
//
//    // MARK: - Setup Methods
//
//    private func setupUI() {
//        [profilePage, nameTextField, profileImageView, tableView, nickNameTextField, introduceTextField].forEach {
//            view.addSubview($0)
//        }
//
//        tableView.dataSource = self
//        tableView.delegate = self
//    }
//
//    private func setConstraints() {
//        profilePage.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
//            $0.leading.equalToSuperview().offset(24)
//        }
//
//        profileImageView.snp.makeConstraints {
//            $0.top.equalTo(profilePage.snp.bottom).offset(20)
//            $0.centerX.equalToSuperview()
//            $0.width.height.equalTo(100)
//        }
//
//        nameTextField.snp.makeConstraints {
//            $0.top.equalTo(profileImageView.snp.bottom).offset(30)
//            $0.centerX.equalToSuperview()
//        }
//
//        nickNameTextField.snp.makeConstraints {
//            $0.top.equalTo(nameTextField.snp.bottom).offset(8)
//            $0.centerX.equalToSuperview()
//        }
//
//        introduceTextField.snp.makeConstraints {
//            $0.top.equalTo(nickNameTextField.snp.bottom).offset(8)
//            $0.centerX.equalToSuperview()
//        }
//
//        tableView.snp.makeConstraints {
//            $0.top.equalTo(introduceTextField.snp.bottom).offset(20)
//            $0.leading.trailing.equalToSuperview().inset(20)
//            $0.bottom.equalToSuperview()
//        }
//    }
//
//    func setupNavigationBar() {
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
//    }
//
//    @objc func saveButtonTapped() {
//        saveUserData()
//    }
//
//    // Firestore에 사용자 데이터 저장
//    private func saveUserData() {
//        // 사용자 입력 데이터 가져오기
//        let name = nameTextField.text ?? ""
//        let nickname = nickNameTextField.text ?? ""
//        let shortDescription = introduceTextField.text ?? ""
//
//        // 테이블 뷰의 각 셀의 값을 가져오기
//        for (index, key) in userInfo.enumerated() {
//            if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)),
//               let textField = cell.contentView.subviews.compactMap({ $0 as? UITextField }).first {
//                userDetails[key] = textField.text ?? ""
//                print("\(key): \(textField.text ?? "")")  // 디버그 로그 추가
//            }
//        }
//
//        // User.Info 구조체 생성
//        let userInfo = User.Info(
//            career: userDetails["직업"] ?? "",
//            education: userDetails["최종학력"] ?? "",
//            email: userDetails["이메일"] ?? "",
//            location: userDetails["거주지"] ?? "",
//            name: name,
//            phoneNumber: userDetails["휴대번호"] ?? "",
//            shortDescription: shortDescription,
//            profileImage: "profile_image_url",  // 예시로 고정된 URL, 실제로는 사용자 입력을 받아야 합니다.
//            nickname: nickname
//        )
//
//        // User 객체 생성
//        let user = User(info: userInfo, preset: [], friendList: [], userId: "some_user_id")
//
//        // FirebaseManager를 사용하여 Firestore에 데이터 추가
//        FirebaseManager.shared.addUser(user: user)
//    }
//
//    // MARK: - UITableViewDataSource Methods
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return userInfo.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = userInfo[indexPath.row]
//
//        let textField: UITextField = {
//            let textField = UITextField()
//            textField.clearButtonMode = .always
//            textField.placeholder = "Value"
//            return textField
//        }()
//
//        cell.contentView.addSubview(textField)
//        textField.snp.makeConstraints {
//            $0.trailing.equalToSuperview().inset(20)
//            $0.centerY.equalToSuperview()
//            $0.width.equalTo(200)
//        }
//
//        return cell
//    }
//
//    // MARK: - ViewModel Binding
//
//    private func bindViewModel() {
//        let saveTap = navigationItem.leftBarButtonItem!.rx.tap.asObservable()
//        let nameText = nameTextField.rx.text.orEmpty.asObservable()
//        let nicknameText = nickNameTextField.rx.text.orEmpty.asObservable()
//        let shortDescriptionText = introduceTextField.rx.text.orEmpty.asObservable()
//
//        let userInfoTexts = Observable.just(userInfo).map { userInfo in
//            userInfo.reduce(into: [String: String]()) { result, key in
//                if let cell = self.tableView.cellForRow(at: IndexPath(row: userInfo.firstIndex(of: key)!, section: 0)),
//                   let textField = cell.contentView.subviews.compactMap({ $0 as? UITextField }).first {
//                    result[key] = textField.text ?? ""
//                }
//            }
//        }
//
//        let input = ProfileEditViewModel.Input(
//            saveTap: saveTap,
//            nameText: nameText,
//            nicknameText: nicknameText,
//            shortDescriptionText: shortDescriptionText,
//            userInfoTexts: userInfoTexts
//        )
//
//        let output = viewModel.transform(input: input)
//
//        output.saveResult
//            .drive(onNext: { [weak self] success in
//                if success {
//                    self?.navigationController?.popViewController(animated: true)
//                } else {
//                    print("Failed to save user data.")
//                }
//            })
//            .disposed(by: disposeBag)
//    }
//}
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import FirebaseFirestore

class ProfileEditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

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
        textField.placeholder = "자기소개를 입력해주세요"
        return textField
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension  // 자동 높이 사용
        tableView.estimatedRowHeight = 44  // 기본 높이 설정
        return tableView
    }()

    private let userInfo = ["휴대번호", "이메일", "거주지", "생년월일", "직업", "회사명", "최종학력", "대학교"]
    private var userDetails: [String: String] = [:]  // 테이블뷰 데이터 저장
    private let disposeBag = DisposeBag()
    private let db = Firestore.firestore()  // Firestore 인스턴스

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupUI()
        setConstraints()
    }

    // MARK: - Setup Methods

    private func setupUI() {
        [profilePage, nameTextField, profileImageView, tableView, nickNameTextField, introduceTextField].forEach {
            view.addSubview($0)
        }

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

    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
    }

    @objc func saveButtonTapped() {
        saveUserData()
    }

    // Firestore에 사용자 데이터 저장
    private func saveUserData() {
        // 사용자 입력 데이터 가져오기
        let name = nameTextField.text ?? ""
        let nickname = nickNameTextField.text ?? ""
        let shortDescription = introduceTextField.text ?? ""

        // 테이블 뷰의 각 셀의 값을 가져오기
        for (index, key) in userInfo.enumerated() {
            if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)),
               let textField = cell.contentView.subviews.compactMap({ $0 as? UITextField }).first {
                userDetails[key] = textField.text ?? ""
                print("\(key): \(textField.text ?? "")")  // 디버그 로그 추가
            }
        }

        // User.Info 구조체 생성
        let userInfo = User.Info(
            career: userDetails["직업"] ?? "",
            education: userDetails["최종학력"] ?? "",
            email: userDetails["이메일"] ?? "",
            location: userDetails["거주지"] ?? "",
            name: name,
            phoneNumber: userDetails["휴대번호"] ?? "",
            shortDescription: shortDescription,
            profileImage: "profile_image_url",  // 예시로 고정된 URL, 실제로는 사용자 입력을 받아야 합니다.
            nickname: nickname
        )

        // User 객체 생성
        let user = User(info: userInfo, preset: [], friendList: [], userId: "some_user_id")

        // Firestore에 User 객체 저장
        saveUserToFirestore(user: user)
    }

    // Firestore에 User 객체 저장 메서드
    private func saveUserToFirestore(user: User) {
        do {
            try db.collection("users").document(user.userId).setData(from: user) { error in
                if let error = error {
                    print("Error writing document: \(error.localizedDescription)")
                } else {
                    print("Document successfully written!")
                    // 저장 후 이전 화면으로 돌아가기
                    self.navigationController?.popViewController(animated: true)
                }
            }
        } catch let error {
            print("Error encoding user: \(error.localizedDescription)")
        }
    }

    // MARK: - UITableViewDataSource Methods

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
