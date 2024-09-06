//
//  SectionHeaderView.swift
//  matnamana
//
//  Created by pc on 9/6/24.
//

import UIKit

import SnapKit
import Then

final class ReputaionSectionHeaderView: UICollectionReusableView {
  static let id = "ReputaionSectionHeaderView"
  
  private let titleLabel = UILabel().then {
    $0.font = UIFont.boldSystemFont(ofSize: 24)
    $0.textColor = .black
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  func configure(with title: String) {
    titleLabel.text = title
  }
}
