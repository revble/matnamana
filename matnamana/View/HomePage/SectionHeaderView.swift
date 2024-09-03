//
//  SectionHeaderView.swift
//  matnamana
//
//  Created by pc on 9/2/24.
//

import UIKit
import SnapKit

class SectionHeaderView: UICollectionReusableView {
  static let id = "SectionHeader"
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.textColor = .white
    return label
  }()
  
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
