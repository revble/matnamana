//
//  SearchVIew.swift
//  matnamana
//
//  Created by 김윤홍 on 8/28/24.
//

import UIKit

import SnapKit
import Then

class SearchView: UIView {
  
  let logo: UIImageView = UIImageView().then {
    $0.image = UIImage()
  }
  
  let searchBar: UISearchBar = UISearchBar().then {
    $0.placeholder = "친구를 검색해보세요!"
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.addSubview(searchBar)
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setConstraints() {
    searchBar.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide).offset(100)
      $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
    }
  }
}
