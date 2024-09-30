
//  ProfileView.swift
//  matnamana
//
//  Created by 이진규 on 9/2/24.
//
//
//import UIKit
//import SnapKit
//
//class ProfileUIView: UIView {
//  
//  
//  
//  let profileImageView: UIImageView = {
//    let imageView = UIImageView()
//    imageView.image = UIImage(named: "profile")
//    imageView.contentMode = .scaleAspectFill
//    imageView.layer.cornerRadius = 75
//    imageView.clipsToBounds = true
//    imageView.isUserInteractionEnabled = true
//    return imageView
//  }()
//  
//  private let nameAgeStackView: UIStackView = {
//    let stackView = UIStackView()
//    stackView.axis = .horizontal
//    stackView.spacing = 8
//    stackView.alignment = .center
//    return stackView
//  }()
//  
//  let nameLabel: UILabel = {
//    let label = UILabel()
//    label.text = "이름"
//    label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
//    return label
//  }()
//
//  let nickNameLabel: UILabel = {
//    let label = UILabel()
//    label.text = "닉네임"
//    label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
//    return label
//  }()
//  
//  let introduceLabel: UILabel = {
//    let label = UILabel()
//    label.text = "자기소개"
//    label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
//
//
//    return label
//  }()
//  
//  let tableView: UITableView = {
//    let tableView = UITableView()
//    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//    tableView.rowHeight = UITableView.automaticDimension
//    tableView.estimatedRowHeight = 44
//    return tableView
//  }()
//  
//  override init(frame: CGRect) {
//    super.init(frame: frame)
//    setupUI()
//    setConstraints()
//  }
//  
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//  
//  private func setupUI() {
//    tableView.tableHeaderView = nameAgeStackView
//    [
//      tableView
//    ].forEach {
//      addSubview($0)
//    }
//
//    [
//      profileImageView,
//      nameLabel,
//     nickNameLabel,
//     introduceLabel,
//    ].forEach {
//      nameAgeStackView.addArrangedSubview($0)
//    }
//  }
//  
//  private func setConstraints() {
//    
//    
//    profileImageView.snp.makeConstraints {
//      $0.top.equalToSuperview().offset(110)
//      $0.centerX.equalToSuperview()
//      $0.width.height.equalTo(150)
//    }
//
//    
//    nickNameLabel.snp.makeConstraints {
//      $0.top.equalTo(profileImageView.snp.bottom).offset(3)
//      $0.centerX.equalToSuperview()
//    }
//    
//    introduceLabel.snp.makeConstraints {
//      $0.top.equalTo(nickNameLabel.snp.bottom).offset(3)
//      $0.centerX.equalToSuperview()
//    }
//    
//    tableView.snp.makeConstraints {
//      $0.edges.equalTo(safeAreaLayoutGuide)
//    }
//  }
//}
import UIKit
import SnapKit

class ProfileUIView: UIView {

  let profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "profile")
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 75
    imageView.clipsToBounds = true
    imageView.isUserInteractionEnabled = true
    return imageView
  }()

  private let nameAgeStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical // 세로 방향으로 스택뷰 변경
    stackView.spacing = 8
    stackView.alignment = .center
    return stackView
  }()

  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "이름"
    label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
    return label
  }()

  let nickNameLabel: UILabel = {
    let label = UILabel()
    label.text = "닉네임"
    label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    return label
  }()

  let introduceLabel: UILabel = {
    let label = UILabel()
    label.text = "자기소개"
    label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
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
    // 스택뷰에 뷰 추가
    [profileImageView, nameLabel, nickNameLabel, introduceLabel].forEach {
      nameAgeStackView.addArrangedSubview($0)
    }

    // 테이블뷰의 헤더로 스택뷰 설정
    tableView.tableHeaderView = nameAgeStackView

    // 테이블뷰 추가
    addSubview(tableView)
  }

  private func setConstraints() {
    // 스택뷰의 크기 및 위치 설정

    profileImageView.snp.makeConstraints{
      $0.width.height.equalTo(150)
    }

    nameAgeStackView.snp.makeConstraints {
      $0.width.equalToSuperview() // 스택뷰의 너비를 전체 뷰에 맞게 설정
    }

    // 테이블뷰의 레이아웃 설정
    tableView.snp.makeConstraints {
      $0.edges.equalTo(safeAreaLayoutGuide)
    }

    // 스택뷰 레이아웃 업데이트
    layoutIfNeeded() // tableHeaderView의 크기를 업데이트
  }
}
