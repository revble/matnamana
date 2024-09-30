//
//  ProfileEditViewController.swift
//  matnamana
//
//  Created by 이진규 on 8/30/24.
// 키보드올라올때 화면 올라가게
//
import UIKit

import SnapKit

final class ProfileEditView: UIView {


  let profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "profile")
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 75
    imageView.clipsToBounds = true
    imageView.isUserInteractionEnabled = true
    return imageView
  }()

  let nameTextField: UILabel = {
    let uiLabel = UILabel()
    uiLabel.text = "김민지"
    uiLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
    return uiLabel
  }()

  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(ProfileEditCell.self, forCellReuseIdentifier: String(describing: ProfileEditCell.self))
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 44
    return tableView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    setConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configureUI() {
    [
      profileImageView,
      nameTextField,
      tableView
    ].forEach {
      addSubview($0)
    }
  }

  private func setConstraints() {

    profileImageView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(110)
      $0.centerX.equalToSuperview()
      $0.width.height.equalTo(150)
    }

    nameTextField.snp.makeConstraints {
      $0.top.equalTo(profileImageView.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
    }

    tableView.snp.makeConstraints {
      $0.top.equalTo(nameTextField.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
    }
  }
}
