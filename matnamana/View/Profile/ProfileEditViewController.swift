//
//  ProfileEditViewController.swift
//  matnamana
//
//  Created by 이진규 on 9/2/24.
//

import UIKit

import SnapKit
import RxCocoa
import RxKeyboard
import RxSwift
import FirebaseStorage

class ProfileEditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  // MARK: - UI Components
  private var profileEditView = ProfileEditView()
  private let disposeBag = DisposeBag()
  
  // Firebase Storage 참조
  private let storage = Storage.storage()
  private var profileImageUrl: String = ""
  
  // 사용자 정보 필드
  private let userInfo = ["휴대번호", "이메일", "거주지", "생년월일", "직업", "회사명", "최종학력", "대학교"]
  
  override func loadView() {
    profileEditView = ProfileEditView()
    self.view = profileEditView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    bindUI()
    //subscribe()
    
    profileEditView.tableView.dataSource = self
    profileEditView.tableView.delegate = self
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
    profileEditView.profileImageView.addGestureRecognizer(tapGesture)
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
        self.saveUserData()
        self.navigateToProfileController()  // ProfileController로 이동
      })
      .disposed(by: disposeBag)
  }
  
  // MARK: - Image Picker and Upload Logic
  // 고쳐야함
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
    let name = profileEditView.nameTextField.text ?? ""
    let nickname = profileEditView.nickNameTextField.text ?? ""
    let shortDescription = profileEditView.introduceTextField.text ?? ""
    
    var userDetails: [String: String] = [:]
    for (index, key) in userInfo.enumerated() {
      if let cell = profileEditView.tableView.cellForRow(at: IndexPath(row: index, section: 0)),
         let textField = cell.contentView.subviews.compactMap({ $0 as? UITextField }).first {
        userDetails[key] = textField.text ?? ""
      }
    }
    
    let info1 = User(info: User.Info(
      career: userDetails["직업"] ?? "",
      education: userDetails["최종학력"] ?? "",
      email: userDetails["이메일"] ?? "",
      location: userDetails["거주지"] ?? "",
      name: name,
      phoneNumber: userDetails["휴대번호"] ?? "",
      shortDescription: shortDescription,
      profileImage: profileImageUrl,
      nickName: nickname), preset: [], friendList: [], userId: "user_id_9812")
    FirebaseManager.shared.addUser(user: info1)
    //생년월일
    //회사명
    //대학교
    
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
  // 키보드
  //  func subscribe() {
  //    RxKeyboard.instance.visibleHeight
  //      .drive(onNext: { [unowned self] keyboardHeigt in
  //        let height = keyboardHeigt > 0 ? -keyboardHeigt +
  //        view.safeAreaInsets.bottom : 0
  //          profileEditView.tableView.snp.updateConstraints {
  //          $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(height)
  //        }
  //
  //        view.layoutIfNeeded()
  //      })
  //      .disposed(by: disposeBag)
  //  }
  
  // MARK: - 네비게이션 메서드 추가
  
  private func navigateToProfileController() {
    let profileController = ProfileController()  // ProfileController의 인스턴스 생성
    self.navigationController?.popViewController(animated: true)
  }
  
  
}