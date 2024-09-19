//
//  MypageInfoCell.swift
//  matnamana
//
//  Created by 이진규 on 9/19/24.
//

import UIKit

import SnapKit
import Then

final class MypageInfoCell: UITableViewCell {

  private let MypageInfoCellLabel = UILabel().then {
    $0.text = ""
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
    setConstraints()
    setupAccessoryType()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:d) has not been implemented")
  }

  private func configureUI() {
    contentView.addSubview(MypageInfoCellLabel)
  }

  private func setConstraints() {
    MypageInfoCellLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().inset(20)
    }
  }

  func configureCell(myPageInfoCell: String) {
    MypageInfoCellLabel.text = myPageInfoCell
  }

  private func setupAccessoryType() {
    self.accessoryType = .disclosureIndicator
  }
}

