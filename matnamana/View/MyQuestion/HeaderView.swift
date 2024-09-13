//
//  HeaderView.swift
//  matnamana
//
//  Created by 김윤홍 on 9/13/24.
//

import UIKit

import SnapKit
import Then

final class HeaderView: UICollectionReusableView {
  
  private let titleLabel = UILabel().then {
    $0.font = UIFont.boldSystemFont(ofSize: 18)
    $0.textColor = .black
    $0.textAlignment = .left
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(10)
    }
  }
  
  func configure(with title: String) {
    titleLabel.text = title
  }
}
