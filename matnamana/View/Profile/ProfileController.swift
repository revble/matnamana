//
//  ProfileController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/23/24.
// 키보드올라올때 화면 올라가게

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class ProfileController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

  // MARK: - UI Components

  private var profileView = ProfileUIView()  // UIView 클래스 인스턴스
  private let viewModel = ProfileViewModel()
  //  private let infoTableView = ProfileTableViewController()
  // MARK: - Data

  private let userInfoKeys = ["휴대번호", "이메일", "거주지", "생년월일", "직업", "회사명", "최종학력", "대학교"]
  private var userValues = ["", "", "", "", "", "", "", ""]

  // MARK: - Lifecycle

  override func loadView() {
    self.view = profileView
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)

    view.backgroundColor = .white
    bindViewModel()

    profileView.tableView.dataSource = self
    profileView.tableView.delegate = self
  }

  override func setNavigation() {
    super.setNavigation()

    let editButton = UIBarButtonItem(title: "수정", style: .plain, target: nil, action: nil)
    navigationItem.rightBarButtonItem = editButton

    editButton.rx.tap
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        self.navigationController?.pushViewController(ProfileEditViewController(), animated: true)
      })
      .disposed(by: disposeBag)
  }


  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return userInfoKeys.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = userInfoKeys[indexPath.row]

    // 기존 UILabel 제거 및 직접 추가 (간결화)
    let valueLabel = UILabel()
    valueLabel.text = userValues[indexPath.row]
    valueLabel.textAlignment = .right
    valueLabel.textColor = .gray

    // 중복 추가 방지
    cell.contentView.subviews.forEach { $0.removeFromSuperview() }

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
        guard let self = self else { return }
        self.profileView.nameLabel.text = profile.name
        self.profileView.nickNameLabel.text = "닉네임:\(profile.nickName)"
        self.profileView.introduceLabel.text = profile.shortDescription
        self.profileView.profileImageView.loadImage(from: profile.profileImage)

        // TableView 데이터 업데이트
        self.userValues = [
          profile.phoneNumber,
          profile.email,
          profile.location,
          profile.career,
          profile.education,
          profile.birth,
          profile.university,
          profile.companyName
        ]
        self.profileView.tableView.reloadData()
      })
      .disposed(by: disposeBag)

    output.userAge
      .drive(onNext: { [weak self] age in
        self?.profileView.ageLabel.text = "(나이: \(age)세)"
      })
      .disposed(by: disposeBag)
  }


}

// MARK: - UIImageView Extension
// 킹피셔 사용법
//테이블뷰 나누기
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
