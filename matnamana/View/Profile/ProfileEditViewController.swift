//
//  ProfileEditViewController.swift
//  matnamana
//
//  Created by 이진규 on 8/30/24.
//
//import UIKit
//import SnapKit
//
//protocol ProfileEditViewController: AnyObject {
//    func didUpdateInfo(type: String, value: String)
//}
//
//class ProfileEditViewController: UIViewController {
//    private var infoType: String
//    private var infoValue: String?
//    weak var delegate: ProfileEditViewController?
//
//    private let infoLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//        return label
//    }()
//
//    private let infoTextField: UITextField = {
//        let textField = UITextField()
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
//    private let saveButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("저장", for: .normal)
//        return button
//    }()
//
//    init(infoType: String, infoValue: String?, delegate: ProfileEditViewController) {
//        self.infoType = infoType
//        self.infoValue = infoValue
//        self.delegate = delegate
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        setConstraints()
//        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
//    }
//
//    private func setupUI() {
//        view.backgroundColor = .white
//        infoLabel.text = "\(infoType) 수정"
//        infoTextField.text = infoValue
//
//        [infoLabel, infoTextField, saveButton].forEach { view.addSubview($0) }
//    }
//
//    private func setConstraints() {
//        infoLabel.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//            $0.leading.equalToSuperview().offset(20)
//        }
//
//        infoTextField.snp.makeConstraints {
//            $0.top.equalTo(infoLabel.snp.bottom).offset(20)
//            $0.leading.trailing.equalToSuperview().inset(20)
//            $0.height.equalTo(40)
//        }
//
//        saveButton.snp.makeConstraints {
//            $0.top.equalTo(infoTextField.snp.bottom).offset(20)
//            $0.centerX.equalToSuperview()
//        }
//    }
//
//    @objc private func saveButtonTapped() {
//        if let newValue = infoTextField.text, !newValue.isEmpty {
//            delegate?.didUpdateInfo(type: infoType, value: newValue)
//            self.navigationController?.popViewController(animated: true)
//        }
//    }
//}
//let valueLabel: UILabel = {
//         let label = UILabel()
//         label.text = userValues[indexPath.row]
//         label.textAlignment = .right
//         label.textColor = .gray
//         return label
//     }()
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
            nameLabel,
            profileImageView,
            tableView
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

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
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

