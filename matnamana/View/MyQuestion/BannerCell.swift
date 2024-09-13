//
//  BannerCell.swift
//  matnamana
//
//  Created by 김윤홍 on 9/12/24.
//

import UIKit

import SnapKit
import Then

final class BannerCell: UICollectionViewCell {
  private let bannerImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    contentView.addSubview(bannerImageView)
    bannerImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  func configure(with image: UIImage) {
    bannerImageView.image = image
  }
}
