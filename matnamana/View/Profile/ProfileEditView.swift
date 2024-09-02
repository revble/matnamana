//
//  ProfileEditViewController.swift
//  matnamana
//
//  Created by 이진규 on 8/30/24.
// 키보드올라올때 화면 올라가게


//import UIKit
//import SnapKit
//import RxSwift
//import RxCocoa
//import FirebaseStorage
//
//class ProfileEditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
//    imageView.isUserInteractionEnabled = true
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
//    textField.placeholder = "자기소개를 입력해주세요"
//    return textField
//  }()
//
//  private let tableView: UITableView = {
//    let tableView = UITableView()
//    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//    tableView.rowHeight = UITableView.automaticDimension
//    tableView.estimatedRowHeight = 44
//    return tableView
//  }()
//
//  private let userInfo = ["휴대번호", "이메일", "거주지", "생년월일", "직업", "회사명", "최종학력", "대학교"]
//  private let disposeBag = DisposeBag()
//  private let viewModel = ProfileEditViewModel()
//
//  private let storage = Storage.storage()
//  private var profileImageUrl: String = ""  // 업로드된 이미지 URL을 저장할 변수 추가
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    view.backgroundColor = .white
//    setupNavigationBar()
//    setupUI()
//    setConstraints()
//    bindViewModel()
//
//    // 프로필 이미지 뷰에 탭 제스처 추가
//    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
//    profileImageView.addGestureRecognizer(tapGesture)
//  }
//
//  // MARK: - Setup Methods
//
//  private func setupUI() {
//    [profilePage, profileImageView, nameTextField, nickNameTextField, introduceTextField, tableView].forEach {
//      view.addSubview($0)
//    }
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
//    nameTextField.snp.makeConstraints {
//      $0.top.equalTo(profileImageView.snp.bottom).offset(30)
//      $0.centerX.equalToSuperview()
//    }
//
//    nickNameTextField.snp.makeConstraints {
//      $0.top.equalTo(nameTextField.snp.bottom).offset(8)
//      $0.centerX.equalToSuperview()
//    }
//
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
//  private func setupNavigationBar() {
//    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
//  }
//
//  @objc private func saveButtonTapped() {
//    saveUserData()
//  }
//
//  // MARK: - 프로필 이미지 선택 및 업로드
//
//  @objc private func profileImageTapped() {
//    let imagePicker = UIImagePickerController()
//    imagePicker.delegate = self
//    imagePicker.sourceType = .photoLibrary
//    imagePicker.allowsEditing = true
//    present(imagePicker, animated: true, completion: nil)
//  }
//
//  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//    picker.dismiss(animated: true, completion: nil)
//
//    if let selectedImage = info[.editedImage] as? UIImage {
//      profileImageView.image = selectedImage
//      uploadImageToFirebase(image: selectedImage)
//    }
//  }
//
//  private func uploadImageToFirebase(image: UIImage) {
//    guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
//    let filePath = "profileImages/\(UUID().uuidString).jpg"
//    let metaData = StorageMetadata()
//    metaData.contentType = "image/jpeg"
//
//    storage.reference().child(filePath).putData(imageData, metadata: metaData) { [weak self] metaData, error in
//      if let error = error {
//        print("Error uploading image: \(error.localizedDescription)")
//        return
//      }
//      print("Image successfully uploaded to Firebase Storage!")
//      self?.storage.reference().child(filePath).downloadURL { url, error in
//        if let error = error {
//          print("Error fetching download URL: \(error.localizedDescription)")
//          return
//        }
//        guard let downloadUrl = url else { return }
//        self?.profileImageUrl = downloadUrl.absoluteString  // 업로드된 이미지 URL 저장
//        print("Download URL: \(self?.profileImageUrl ?? "")")
//      }
//    }
//  }
//
//  // MARK: - Firestore에 사용자 데이터 저장
//
//  private func saveUserData() {
//    let name = nameTextField.text ?? ""
//    let nickname = nickNameTextField.text ?? ""
//    let shortDescription = introduceTextField.text ?? ""
//
//    var userDetails: [String: String] = [:]
//    for (index, key) in userInfo.enumerated() {
//      if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)),
//         let textField = cell.contentView.subviews.compactMap({ $0 as? UITextField }).first {
//        userDetails[key] = textField.text ?? ""
//      }
//    }
//
//    let info1 = User(info: User.Info(
//      career: userDetails["직업"] ?? "",
//      education: userDetails["최종학력"] ?? "",
//      email: userDetails["이메일"] ?? "",
//      location: userDetails["거주지"] ?? "",
//      name: name,
//      phoneNumber: userDetails["휴대번호"] ?? "",
//      shortDescription: shortDescription,
//      profileImage: profileImageUrl,  // 이미지 URL 저장
//      nickname: nickname), preset: [], friendList: [], userId: "user_id_1456")
//    FirebaseManager.shared.addUser(user: info1)
//  }
//
//  // MARK: - UITableViewDataSource Methods
//
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
//      textField.text = ""
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
//
//  // MARK: - ViewModel Binding
//
//  private func bindViewModel() {
//    let saveTap = navigationItem.leftBarButtonItem!.rx.tap.asObservable()
//    let nameText = nameTextField.rx.text.orEmpty.asObservable()
//    let nicknameText = nickNameTextField.rx.text.orEmpty.asObservable()
//    let shortDescriptionText = introduceTextField.rx.text.orEmpty.asObservable()
//
//    let userInfoTexts = Observable.just(userInfo).map { userInfo in
//      userInfo.reduce(into: [String: String]()) { result, key in
//        if let cell = self.tableView.cellForRow(at: IndexPath(row: userInfo.firstIndex(of: key)!, section: 0)),
//           let textField = cell.contentView.subviews.compactMap({ $0 as? UITextField }).first {
//          result[key] = textField.text ?? ""
//        }
//      }
//    }
//
//    let profileImageObservable = Observable.just(profileImageUrl)  // 프로필 이미지 URL 전달
//
//    let input = ProfileEditViewModel.Input(
//      saveTap: saveTap,
//      nameText: nameText,
//      nicknameText: nicknameText,
//      shortDescriptionText: shortDescriptionText,
//      userInfoTexts: userInfoTexts,
//      profileImageUrl: profileImageObservable  // ViewModel에 URL 전달
//    )
//
//    let output = viewModel.transform(input: input)
//
//    output.saveResult
//      .drive(onNext: { [weak self] (success: Bool) in  // success의 타입 명시
//        if success {
//          self?.navigationController?.popViewController(animated: true)
//        } else {
//          print("Failed to save user data.")
//        }
//      })
//      .disposed(by: disposeBag)
//  }
//}
import UIKit
import SnapKit

class ProfileEditView: UIView {

  // MARK: - UI Components

  let profilePage: UILabel = {
    let label = UILabel()
    label.text = "나의 정보"
    label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
    return label
  }()

  let profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "profile")
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 50
    imageView.clipsToBounds = true
    imageView.isUserInteractionEnabled = true
    return imageView
  }()

  let nameTextField: UITextField = {
    let textField = UITextField()
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.black.cgColor
    textField.layer.cornerRadius = 5
    textField.placeholder = "이름을 입력해주세요"
    return textField
  }()

  let nickNameTextField: UITextField = {
    let textField = UITextField()
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.black.cgColor
    textField.layer.cornerRadius = 5
    textField.clearButtonMode = .always
    textField.placeholder = "닉네임을 입력해주세요"
    return textField
  }()

  let introduceTextField: UITextField = {
    let textField = UITextField()
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.black.cgColor
    textField.layer.cornerRadius = 5
    textField.clearButtonMode = .always
    textField.placeholder = "자기소개를 입력해주세요"
    return textField
  }()

  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 44
    return tableView
  }()

  // MARK: - Initializers

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    setConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup Methods

  private func configureUI() {
    [profilePage, profileImageView, nameTextField, nickNameTextField, introduceTextField, tableView].forEach {
      addSubview($0)
    }
  }

  private func setConstraints() {
    profilePage.snp.makeConstraints {
      $0.top.equalTo(safeAreaLayoutGuide).offset(8)
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
}
