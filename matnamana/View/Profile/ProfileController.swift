//
//  ProfileController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/23/24.
//

//import FirebaseFirestore
//
//class ProfileController: UIViewController {
//    override func viewDidLoad() {
//      super.viewDidLoad()
//    }
//
//    func checkAndCreateDocuments(userId: String) {
//        let db = Firestore.firestore()
//
//        // 'users' 컬렉션에서 문서 가져오기
//        db.collection("users").document(userId).getDocument { snapshot, error in
//            if let error = error {
//                print("Error fetching document: \(error)")
//                return
//            }
//            guard snapshot?.exists == false else { return } // Check if document exists
//            let batch = db.batch()
//            let userRef = db.collection("users").document(userId)
//
//            batch.setData([
//                "name": "KYU",
//                "MBTI": "ENTJ"
//            ], forDocument: userRef)
//
//            // 배치 커밋
//            batch.commit { error in
//                if let error = error {
//                    print("Error writing batch: \(error)")
//                } else {
//                    print("Batch write succeeded.")
//                }
//            }
//            // 데이터 커밋 후 추가 로그 출력
//            print("Attempted to write to Firestore.")
//        }
//    }
//}

//import UIKit
//import FirebaseCore
//import FirebaseFirestore
//
//class ProfileController: UIViewController {
//    let db = Firestore.firestore()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        addDocumentWithAutoID()
//    }
//
//    func addDocumentWithAutoID() {
//        // 자동으로 생성된 ID로 'users' 컬렉션에 새 문서 추가
//        db.collection("users").addDocument(data: [
//            "name": "KYU",
//            "MBTI": "ENTJ"
//        ]) { error in
//            if let error = error {
//                print("Error adding document: \(error.localizedDescription)")
//            } else {
//                print("Document successfully added with auto-generated ID!")
//            }
//        }
//    }
//}
//
//class ProfileController: UIViewController {
//    let db = Firestore.firestore()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        addDocumentWithAutoID()
//    }
//
//    func addDocumentWithAutoID() {
//        // 자동으로 생성된 ID로 'users' 컬렉션에 새 문서 추가
//        db.collection("users").addDocument(data: [
//            "name": "KYU",
//            "MBTI": "ENTJ"
//        ]) { error in
//            if let error = error {
//                print("Error adding document: \(error.localizedDescription)")
//            } else {
//                print("Document successfully added with auto-generated ID!")
//            }
//        }
//    }
//}


//    override func viewDidLoad() {
////        super.viewDidLoad()
////
////        let userId = "uniqueUserId123" // 실제 사용자 ID로 변경
////        checkAndCreateDocuments(userId: userId)
//    }
//
//    func checkAndCreateDocuments(userId: String) {
//        let db = Firestore.firestore()
//
//        // 'users' 컬렉션에서 문서 가져오기
//        db.collection("users").document(userId).getDocument { snapshot, error in
//            if let error = error {
//                print("Error fetching document: \(error)")
//                return
//            }
//            guard snapshot?.exists == false else {
//                print("Document already exists.")
//                return
//            }
//
//            // 문서가 존재하지 않으면 새 문서 생성 (setData)
//            db.collection("users").document(userId).setData([
//                "name": "KYU",
//                "MBTI": "ENTJ"
//           ]) //{ error in
////                if let error = error {
////                    print("Error writing document: \(error)")
////                } else {
////                    print("Document successfully written!")
////                }
////            }
//        }
//    }
//}

//import UIKit
//
//import FirebaseFirestore
//
//class ProfileController: UIViewController {
//    let db = Firestore.firestore()
//
//    func saveUser(user: User, userID: String) {
//        do{
//            try db.collection("users").document(userID).setData(from: user) { error in
//                if let error = error {
//                    print("Error writing document: \(error)")
//                } else {
//                    print("Document successfully written!")
//                }
//            }
//        } catch let error {
//            print("Error encoding user: \(error)")
//        }
//    }
//
//    func loadUser(id: String) {
//        do {
//            try db.collection("users").document()
//        }
//    }
//
//    let user = User(info: User.Info(name: "KYU", MBTI: "ENTJ"), preset: [User.PresetQuestion(presetTitle: "j1", indice: [1,2,3,])], friendList: [User.Friend(nickname: "JJIN", type: .collegue)])
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    saveUser(user: user, userID: "LEE")
//    }
//}

// User 구조체가 Codable을 채택해야 Firestore에서 setData(from:) 사용 가능
//struct User: Codable {
//    struct Info: Codable {
//        let mbti: String
//        let career: String
//        let education: String
//        let email: String
//        let location: String
//        let name: String
//        let phoneNumber: String
//        let shortDescription: String
//        let profileImage: String
//    }
//
//    struct PresetQuestion: Codable {
//        let presetTitle: String
//        let indice: [Int]
//    }
//
//    struct Friend: Codable {
//        let nickname: String
//        let type: FriendType
//    }
//
//    enum FriendType: String, Codable {
//        case family
//        case collegue
//        case friend
//    }
//
//    let info: Info
//    let preset: [PresetQuestion]
//    let friendList: [Friend]
//}






//import UIKit
//import FirebaseFirestore

//class ProfileController: UIViewController { //진짜
//    let db = Firestore.firestore()
//
//    // Firestore에 User 객체 저장
//    func saveUser(user: User, userID: String) {
//        do {
//            try db.collection("users").document(userID).setData(from: user) { error in
//                if let error = error {
//                    print("Error writing document: \(error.localizedDescription)")
//                } else {
//                    print("Document successfully written!")
//                }
//            }
//        } catch let error {
//            print("Error encoding user: \(error.localizedDescription)")
//        }
//    }
//
//    // Firestore에서 User 객체 로드
//    func loadUser(id: String) {
//        let docRef = db.collection("users").document(id)
//        docRef.getDocument(as: User.self) { result in
//            switch result {
//            case .success(let user):
//                print("User loaded: \(user)")
//            case .failure(let error):
//                print("Error loading user: \(error.localizedDescription)")
//            }
//        }
//    }
//
//    // User 객체 생성 시 모든 필드 제공
//    let user = User(
//        info: User.Info(
//            mbti: "ENTJ",
//            career: "Developer",
//            education: "Bachelor",
//            email: "example@example.com",
//            location: "Seoul",
//            name: "KYU",
//            phoneNumber: "010-1234-5678",
//            shortDescription: "Swift Developer",
//            profileImage: "nill"
//        ),
//        preset: [
//            User.PresetQuestion(presetTitle: "j1", indice: [1, 2, 3])
//        ],
//        friendList: [
//            User.Friend(nickname: "JJIN", type: .collegue)
//        ]
//    )
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Firestore에 사용자 저장
//        saveUser(user: user, userID: "LEE")
//        // 사용자 로드
//        loadUser(id: "LEE")
//    }
//}
//import UIKit//이미지 호출
//import FirebaseStorage
//
//class ProfileController: UIViewController {
//
//    let storage = Storage.storage() // Firebase Storage 인스턴스 생성
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        if let image = UIImage(named: "profile") {
//            upLoadImage(img: image) // 원하는 이미지 업로드
//        }
//    }
//
//    func upLoadImage(img: UIImage) {
//        if let data = img.jpegData(compressionQuality: 0.8) { // 이미지 데이터를 JPEG로 변환
//            let filePath = "profile"
//            let metaData = StorageMetadata()
//            metaData.contentType = "image/png" // 이미지 타입 설정
//            storage.reference().child(filePath).putData(data, metadata: metaData) { metaData, error in
//                if let error = error { // 실패 처리
//                    print(error.localizedDescription)
//                    return
//                }
//                print("성공") // 성공 처리
//            }
//        }
//    }
//}
//import UIKit
//import SnapKit
//
//class ProfileController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "김민지 (나이: 31살)"
//        label.textAlignment = .center
//        return label
//    }()
//
//    private let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        return tableView
//    }()
//
//    private let userInfo = ["휴대번호", "이메일", "거주지", "생년월일", "직업", "회사명", "최종학력", "대학교"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        setConstraints()
//    }
//
//    func setupUI() {
//      [
//        profilePage,
//          nameLabel,
//          profileImageView,
//          tableView
//          ].forEach { self.view.addSubview($0) }
//        tableView.dataSource = self
//        tableView.delegate = self
//    }
//
//    func setConstraints() {
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
//        nameLabel.snp.makeConstraints {
//            $0.top.equalTo(profileImageView.snp.bottom).offset(30)
//            $0.centerX.equalToSuperview()
//        }
//
//        tableView.snp.makeConstraints {
//            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
//            $0.leading.trailing.equalToSuperview().inset(20)
//            $0.bottom.equalToSuperview()
//        }
//    }
//
//    // 테이블 뷰 데이터 소스 메서드
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return userInfo.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = userInfo[indexPath.row]
//
//      let valueLabel: UILabel = {
//               let label = UILabel()
//               label.text = userValues[indexPath.row]
//               label.textAlignment = .right
//               label.textColor = .gray
//               return label
//           }()
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
//}
//let valueLabel: UILabel = {
//         let label = UILabel()
//         label.text = userValues[indexPath.row]
//         label.textAlignment = .right
//         label.textColor = .gray
//         return label
//     }()
//import UIKit
//import FirebaseStorage
//
//class ProfileController: UIViewController {
//
//  let storage = Storage.storage() // Firebase Storage 인스턴스 생성
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    if let image = UIImage(named: "profile") {
//      upLoadImage(img: image) // 원하는 이미지 업로드
//    }
//  }
//
//  func upLoadImage(img: UIImage) {
//    if let data = img.jpegData(compressionQuality: 0.8) { // 이미지 데이터를 JPEG로 변환
//      let filePath = "profile"
//      let metaData = StorageMetadata()
//      metaData.contentType = "image/png" // 이미지 타입 설정
//      let storageRef = storage.reference().child(filePath)
//
//      // 이미지 데이터 업로드
//      storageRef.putData(data, metadata: metaData) { metaData, error in
//        if let error = error { // 실패 처리
//          print(error.localizedDescription)
//          return
//        }
//        print("성공") // 성공 처리
//
//        // 업로드 후 다운로드 URL 가져오기
//        storageRef.downloadURL { url, error in
//          if let error = error {
//            print("Error fetching download URL: \(error.localizedDescription)")
//            return
//          }
//          if let downloadURL = url {
//            print("Download URL: \(downloadURL.absoluteString)")
//          }
//        }
//      }
//    }
//  }
//}
//import UIKit
//import SnapKit
//
//class ProfileController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "김민지 (나이: 31살)"
//        label.textAlignment = .center
//        return label
//    }()
//
//    private let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        return tableView
//    }()
//
//    private let editButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("수정", for: .normal)
//        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
//        return button
//    }()
//
//    private let userInfo = ["휴대번호", "이메일", "거주지", "생년월일", "직업", "회사명", "최종학력", "대학교"]
//    //private let userValues = ["010-1234-5678", ".com", "거주지역", "0000-00-00", "직업", "회사이름", "", ""]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        setConstraints()
//    }
//
//    func setupUI() {
//        [
//            profilePage,
//            nameLabel,
//            profileImageView,
//            tableView,
//            editButton
//        ].forEach { self.view.addSubview($0) }
//
//        tableView.dataSource = self
//        tableView.delegate = self
//    }
//
//    func setConstraints() {
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
//        nameLabel.snp.makeConstraints {
//            $0.top.equalTo(profileImageView.snp.bottom).offset(30)
//            $0.centerX.equalToSuperview()
//        }
//
//        tableView.snp.makeConstraints {
//            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
//            $0.leading.trailing.equalToSuperview().inset(20)
//            $0.bottom.equalToSuperview()
//        }
//
//        editButton.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
//            $0.trailing.equalToSuperview().inset(24)
//        }
//    }
//
//    @objc func editButtonTapped() {
//        let editVC = ProfileEditViewController()
//        navigationController?.pushViewController(editVC, animated: true)
//    }
//
//    // 테이블 뷰 데이터 소스 메서드
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return userInfo.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = userInfo[indexPath.row]
//
//        let valueLabel: UILabel = {
//            let label = UILabel()
//           // label.text = userValues[indexPath.row]
//            label.textAlignment = .right
//            label.textColor = .gray
//            return label
//        }()
//
//        cell.contentView.addSubview(valueLabel)
//        valueLabel.snp.makeConstraints {
//            $0.trailing.equalToSuperview().inset(20)
//            $0.centerY.equalToSuperview()
//        }
//
//        return cell
//    }
//}
//import UIKit
//import SnapKit
//
//class ProfileController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "김민지 (나이: 31살)"
//        label.textAlignment = .center
//        return label
//    }()
//
//    private let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        return tableView
//    }()
//
//    private let editButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("수정", for: .normal)
//        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
//        return button
//    }()
//
//    private let userInfo = ["휴대번호", "이메일", "거주지", "생년월일", "직업", "회사명", "최종학력", "대학교"]
//    private let userValues = ["010-1234-5678", "minji@gmail.com", "서울시", "1992-04-05", "개발자", "ABC회사", "석사", "서울대학교"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        setConstraints()
//    }
//
//    func setupUI() {
//        [
//            profilePage,
//            nameLabel,
//            profileImageView,
//            tableView,
//            editButton
//        ].forEach { self.view.addSubview($0) }
//
//        tableView.dataSource = self
//        tableView.delegate = self
//    }
//
//    func setConstraints() {
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
//        nameLabel.snp.makeConstraints {
//            $0.top.equalTo(profileImageView.snp.bottom).offset(30)
//            $0.centerX.equalToSuperview()
//        }
//
//        tableView.snp.makeConstraints {
//            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
//            $0.leading.trailing.equalToSuperview().inset(20)
//            $0.bottom.equalToSuperview()
//        }
//
//        editButton.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
//            $0.trailing.equalToSuperview().inset(24)
//        }
//    }
//  @objc func editProfile() {
//      let editVC = ProfileEditViewController()
//      self.navigationController?.pushViewController(editVC, animated: true)
//    }
//  }
////    @objc func editButtonTapped() {
////        let editVC = ProfileEditViewController()
////
////        // 네비게이션 컨트롤러가 없으면 새로 생성해서 Present
////        if navigationController == nil {
////            let navController = UINavigationController(rootViewController: editVC)
////            navController.modalPresentationStyle = .fullScreen
////            present(navController, animated: true, completion: nil)
////        } else {
////            navigationController?.pushViewController(editVC, animated: true)
////        }
////    }
//
//    // 테이블 뷰 데이터 소스 메서드
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return userInfo.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = userInfo[indexPath.row]
//
//        let valueLabel: UILabel = {
//            let label = UILabel()
//            label.text = userValues[indexPath.row]
//            label.textAlignment = .right
//            label.textColor = .gray
//            return label
//        }()
//
//        cell.contentView.addSubview(valueLabel)
//        valueLabel.snp.makeConstraints {
//            $0.trailing.equalToSuperview().inset(20)
//            $0.centerY.equalToSuperview()
//        }
//
//        return cell
//    }
//}
//import UIKit
//import SnapKit
//
//// 시작하는 ViewController 설정 부분
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // ProfileController를 네비게이션 컨트롤러로 감싸기
//        let profileController = ProfileController()
//        let navigationController = UINavigationController(rootViewController: profileController)
//
//        navigationController.modalPresentationStyle = .fullScreen
//        present(navigationController, animated: true, completion: nil)
//    }
//}
//
//class ProfileController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "김민지 (나이: 31살)"
//        label.textAlignment = .center
//        return label
//    }()
//
//    private let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        return tableView
//    }()
//
//    private let editButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("수정", for: .normal)
//        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
//        return button
//    }()
//
//    private let userInfo = ["휴대번호", "이메일", "거주지", "생년월일", "직업", "회사명", "최종학력", "대학교"]
//    private let userValues = ["010-1234-5678", "minji@gmail.com", "서울시", "1992-04-05", "개발자", "ABC회사", "석사", "서울대학교"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        setConstraints()
//    }
//
//    func setupUI() {
//        view.backgroundColor = .white  // 배경색 추가
//        self.navigationItem.title = "프로필"  // 네비게이션 타이틀 설정
//
//        [
//            profilePage,
//            nameLabel,
//            profileImageView,
//            tableView,
//            editButton
//        ].forEach { self.view.addSubview($0) }
//
//        tableView.dataSource = self
//        tableView.delegate = self
//    }
//
//    func setConstraints() {
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
//        nameLabel.snp.makeConstraints {
//            $0.top.equalTo(profileImageView.snp.bottom).offset(30)
//            $0.centerX.equalToSuperview()
//        }
//
//        tableView.snp.makeConstraints {
//            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
//            $0.leading.trailing.equalToSuperview().inset(20)
//            $0.bottom.equalToSuperview()
//        }
//
//        editButton.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
//            $0.trailing.equalToSuperview().inset(24)
//        }
//    }
//
//    @objc func editButtonTapped() {
//        print(navigationController) // nil인지 확인하는 코드
//        let editVC = ProfileEditViewController()
//        navigationController?.pushViewController(editVC, animated: true)
//    }
//
//    // 테이블 뷰 데이터 소스 메서드
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return userInfo.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = userInfo[indexPath.row]
//
//        let valueLabel: UILabel = {
//            let label = UILabel()
//            label.text = userValues[indexPath.row]
//            label.textAlignment = .right
//            label.textColor = .gray
//            return label
//        }()
//
//        cell.contentView.addSubview(valueLabel)
//        valueLabel.snp.makeConstraints {
//            $0.trailing.equalToSuperview().inset(20)
//            $0.centerY.equalToSuperview()
//        }
//
//        return cell
//    }
//}
import UIKit
import SnapKit

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
        label.text = "김민지 (나이: 31살)"
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

    private let userInfo = ["휴대번호", "이메일", "거주지", "생년월일", "직업", "회사명", "최종학력", "대학교"]
    private let userValues = ["010-1234-5678", "e.mail", "지역", "0000-00-00", "직업", "회사", "최종학력", "__대학교"]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
    }

    // MARK: - Setup Methods

    private func setupUI() {
        view.addSubview(profilePage)
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(tableView)
        view.addSubview(editButton)

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
            $0.top.equalTo(profileImageView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
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
        return userInfo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = userInfo[indexPath.row]

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
}
