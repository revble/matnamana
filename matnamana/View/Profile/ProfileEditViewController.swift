//
//  ProfileEditViewController.swift
//  matnamana
//
//  Created by 이진규 on 9/2/24.

import UIKit

import SnapKit
import RxCocoa
import RxSwift
import RxKeyboard
import FirebaseStorage

final class ProfileEditViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate,
                                       UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  // MARK: - UI Components
  private var profileEditView = ProfileEditView()
  private let viewModel = ProfileEditViewModel()  // ViewModel 인스턴스 생성
  
  // Firebase Storage 참조
  private let storage = Storage.storage()
  private var profileImageUrl: String = ""
  
  // 사용자 정보 필드
  private let userInfo = ["휴대번호", "이메일", "거주지", "생일", "직업", "회사", "최종학력", "대학교"]
  
  override func loadView() {
    profileEditView = ProfileEditView()
    self.view = profileEditView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    bindUI()
    bindViewModel()
    profileEditView.tableView.dataSource = self
    profileEditView.tableView.delegate = self
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
    profileEditView.profileImageView.addGestureRecognizer(tapGesture)
  }
  
  override func adjustForKeyboardHeight(_ keyboardHeight: CGFloat) {
    super.adjustForKeyboardHeight(keyboardHeight)
  }
  
  
  // MARK: - Setup Methods
  
  private func bindUI() {
    // 네비게이션 바의 "저장" 버튼 생성
    let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: nil, action: nil)
    navigationItem.rightBarButtonItem = saveButton
    
    // "저장" 버튼 탭 이벤트를 RxSwift로 처리
    guard let button = navigationItem.rightBarButtonItem else { return }
    let saveTap = button.rx.tap.asObservable()
    
    // 입력 필드와 Observable 생성
    let nameText = profileEditView.nameTextField.rx.text.orEmpty.asObservable()
    let nicknameText = profileEditView.nickNameTextField.rx.text.orEmpty.asObservable()
    let shortDescriptionText = profileEditView.introduceTextField.rx.text.orEmpty.asObservable()
    
    // 사용자 정보 텍스트 필드 Observable 생성
    let userInfoTexts = Observable.just(userInfo).map { userInfo in
      userInfo.reduce(into: [String: String]()) { result, key in
        if let cell = self.profileEditView.tableView.cellForRow(at: IndexPath(row: userInfo.firstIndex(of: key)!, section: 0)),
           let textField = cell.contentView.subviews.compactMap({ $0 as? UITextField }).first {
          result[key] = textField.text ?? ""
        }
      }
    }
    
    // 프로필 이미지 Observable 생성
    let profileImageObservable = Observable.just(profileImageUrl)
    
    // "저장" 버튼 탭 이벤트 처리
    saveTap
      .withLatestFrom(Observable.combineLatest(nameText, nicknameText, shortDescriptionText, userInfoTexts, profileImageObservable))
      .subscribe(onNext: { [weak self] (name, nickname, shortDescription, userDetails, profileImageUrl) in
        guard let self = self else { return }
        self.saveUserData()  // 저장 메서드 호출
        self.navigateToProfileController()  // ProfileController로 이동
      }).disposed(by: disposeBag)
  }
  
  // 사용자 정보 바인딩 메서드 추가
  private func bindViewModel() {
    let input = ProfileEditViewModel.Input(
      saveTap: navigationItem.rightBarButtonItem!.rx.tap.asObservable(),
      nameText: profileEditView.nameTextField.rx.text.orEmpty.asObservable(),
      nicknameText: profileEditView.nickNameTextField.rx.text.orEmpty.asObservable(),
      shortDescriptionText: profileEditView.introduceTextField.rx.text.orEmpty.asObservable(),
      userInfoTexts: Observable.just(userInfo).map { userInfo in
        userInfo.reduce(into: [String: String]()) { result, field in
          if let rowIndex = userInfo.firstIndex(of: field),
             let cell = self.profileEditView.tableView.cellForRow(at: IndexPath(row: rowIndex, section: 0)),
             let textField = cell.contentView.subviews.compactMap({ $0 as? UITextField }).first {
            result[field] = textField.text ?? ""
          }
        }
      },
      profileImageUrl: Observable.just(profileImageUrl)
    )
    
    let output = viewModel.transform(input: input)
    
    // Firebase에서 가져온 사용자 정보를 UI에 바인딩
    output.currentUserInfo
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] profile in
        guard let self = self else { return }
        self.profileEditView.nameTextField.text = profile.name
        self.profileEditView.nickNameTextField.text = profile.nickName
        self.profileEditView.introduceTextField.text = profile.shortDescription
        self.profileEditView.profileImageView.loadImage(from: profile.profileImage)
        
        // TableView 데이터 업데이트
        let userDetails = [
          profile.phoneNumber,
          profile.email,
          profile.location,
          profile.birth,
          profile.career,
          profile.companyName,
          profile.education,
          profile.university
        ]
        
        for (index, value) in userDetails.enumerated() {
          if let cell = self.profileEditView.tableView.cellForRow(at: IndexPath(row: index, section: 0)),
             let textField = cell.contentView.subviews.compactMap({ $0 as? UITextField }).first {
            textField.text = value
          }
        }
      })
      .disposed(by: disposeBag)
  }
  
  // MARK: - Image Picker and Upload Logic
  @objc private func profileImageTapped() {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = .photoLibrary
    imagePicker.allowsEditing = true
    present(imagePicker, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    picker.dismiss(animated: true, completion: nil)
    
    if let selectedImage = info[.editedImage] as? UIImage {
      profileEditView.profileImageView.image = selectedImage
      uploadImageToFirebase(image: selectedImage)
    }
  }
  
  private func uploadImageToFirebase(image: UIImage) {
    guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
    let filePath = "profileImages/\(UUID().uuidString).jpg"
    let metaData = StorageMetadata()
    metaData.contentType = "image/jpeg"
    
    storage.reference().child(filePath).putData(imageData, metadata: metaData) { [weak self] metaData, error in
      if let error = error {
        print("Error uploading image: \(error.localizedDescription)")
        return
      }
      
      print("Image successfully uploaded to Firebase Storage!")
      self?.storage.reference().child(filePath).downloadURL { url, error in
        if let error = error {
          print("Error fetching download URL: \(error.localizedDescription)")
          return
        }
        guard let downloadUrl = url else { return }
        self?.profileImageUrl = downloadUrl.absoluteString
        print("Download URL: \(self?.profileImageUrl ?? "")")
      }
    }
  }
  
  // MARK: - Save User Data
  
  private func saveUserData() {
    guard let id = UserDefaults.standard.string(forKey: "loggedInUserId") else { return }
    
    // 기존 사용자 데이터 불러오기
    viewModel.fetchProfileData()
      .subscribe(onNext: { [weak self] existingUser in
        guard let self = self else { return }
        
        // 입력된 사용자 정보로 업데이트
        let name = self.profileEditView.nameTextField.text ?? ""
        let nickname = self.profileEditView.nickNameTextField.text ?? ""
        let shortDescription = self.profileEditView.introduceTextField.text ?? ""
        
        var userDetails: [String: String] = [:]
        for (index, key) in self.userInfo.enumerated() {
          if let cell = self.profileEditView.tableView.cellForRow(at: IndexPath(row: index, section: 0)),
             let textField = cell.contentView.subviews.compactMap({ $0 as? UITextField }).first {
            userDetails[key] = textField.text ?? ""
          }
        }
        
        // 기존 preset과 friendList를 유지하며 새로운 사용자 정보 생성
        let updatedInfo = User.Info(
          career: userDetails["직업"] ?? existingUser.info.career,
          education: userDetails["최종학력"] ?? existingUser.info.education,
          email: userDetails["이메일"] ?? existingUser.info.email,
          location: userDetails["거주지"] ?? existingUser.info.location,
          name: name,
          phoneNumber: userDetails["휴대번호"] ?? existingUser.info.phoneNumber,
          shortDescription: shortDescription,
          profileImage: self.profileImageUrl,
          nickName: nickname,
          birth: userDetails["생일"] ?? existingUser.info.birth,
          university: userDetails["대학교"] ?? existingUser.info.university,
          companyName: userDetails["회사"] ?? existingUser.info.companyName
        )
        
        let updatedUser = User(info: updatedInfo, preset: existingUser.preset, friendList: existingUser.friendList, userId: existingUser.userId)
        
        self.viewModel.saveUserData(user: updatedUser)
          .subscribe(onNext: { success in
            if success {
              print("User data saved successfully")
            } else {
              print("Failed to save user data")
            }
          }).disposed(by: self.disposeBag)
      }).disposed(by: disposeBag)
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
      textField.text = ""
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
  
  // MARK: - 네비게이션 메서드 추가
  
  private func navigateToProfileController() {
    self.navigationController?.popViewController(animated: true)
  }
}
