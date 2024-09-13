
//  ProfileView.swift
//  matnamana
//
//  Created by 이진규 on 9/2/24.
//

import UIKit
import SnapKit

class CustomLabel: UILabel {
  var textInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

  override func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: textInsets))
  }

  override var intrinsicContentSize: CGSize {
    let size = super.intrinsicContentSize
    return CGSize(width: size.width + textInsets.left + textInsets.right,
                  height: size.height + textInsets.top + textInsets.bottom)
  }
}

class ProfileUIView: UIView {



  let profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "profile")
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 50
    imageView.clipsToBounds = true
    imageView.isUserInteractionEnabled = true
    return imageView
  }()

  private let nameAgeStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 8
    stackView.alignment = .center
    return stackView
  }()

  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "이름"
    label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
    return label
  }()

  let ageLabel: UILabel = {
    let label = UILabel()
    label.text = "나이: 00"
    label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
    label.textAlignment = .left
    return label
  }()

  let nickNameLabel: UILabel = {
    let label = UILabel()
    label.text = "닉네임"
    label.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
    return label
  }()

  let introduceLabel: CustomLabel = {
    let label = CustomLabel()
    label.text = "자기소개"
    label.layer.borderWidth = 1.0
    label.layer.borderColor = UIColor.black.cgColor
    label.layer.cornerRadius = 5
    label.textAlignment = .center
    return label
  }()

  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 44
    return tableView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
    setConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupUI() {
    [
      /*profilePage*/
      profileImageView,
      nameAgeStackView,
      tableView,
      nickNameLabel,
      introduceLabel,
      ageLabel
    ].forEach {
      addSubview($0)
    }
    [
      nameLabel,
      ageLabel
    ].forEach {
      nameAgeStackView.addArrangedSubview($0)
    }
  }

  private func setConstraints() {


    profileImageView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(80)
      $0.centerX.equalToSuperview()
      $0.width.height.equalTo(100)
    }

    nameAgeStackView.snp.makeConstraints {
      $0.top.equalTo(profileImageView.snp.bottom).offset(17)
      $0.centerX.equalToSuperview()
    }

    nickNameLabel.snp.makeConstraints {
      $0.top.equalTo(nameAgeStackView.snp.bottom).offset(3)
      $0.centerX.equalToSuperview()
    }

    introduceLabel.snp.makeConstraints {
      $0.top.equalTo(nickNameLabel.snp.bottom).offset(3)
      $0.centerX.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(20)
    }

    tableView.snp.makeConstraints {
      $0.top.equalTo(introduceLabel.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
    }
  }
}
