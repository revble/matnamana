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
    $0.image = UIImage(named: "fill")
    $0.layer.cornerRadius = 16
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    contentView.addSubview(bannerImageView)
  }
  
  private func setConstraints() {
    
    bannerImageView.snp.makeConstraints {
      $0.horizontalEdges.equalToSuperview().inset(20)
      $0.height.equalTo(120)
    }
  }
}
