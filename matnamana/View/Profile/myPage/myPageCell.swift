//
//  myPageCell.swift
//  matnamana
//
//  Created by 이진규 on 9/13/24.
//

import UIKit

import SnapKit
import Then

final class myPageCell: UITableViewCell {

  let myPageCellLabel = UILabel().then {
    $0.text = ""
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
    setConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  private func configureUI() {
    contentView.addSubview(myPageCellLabel)
  }
  private func setConstraints() {
    myPageCellLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.leading.equalToSuperview().inset(20)
    }
  }

  func configureCell(myPageCell: String) {
    myPageCellLabel.text = myPageCell
  }

}
