//
//  ReputationListCell.swift
//  matnamana
//
//  Created by 김윤홍 on 9/20/24.
//

import UIKit

import SnapKit
import Then

final class ReputationListCell: UITableViewCell {
  
  private let label = UILabel().then {
    $0.text = ""
    $0.numberOfLines = 0
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(label)
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setConstraints() {
    label.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.horizontalEdges.equalToSuperview().inset(16)
    }
  }
  
  func configure(text: String) {
    label.text = text
  }
}
