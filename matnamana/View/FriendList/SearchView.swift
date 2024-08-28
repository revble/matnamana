//
//  SearchVIew.swift
//  matnamana
//
//  Created by 김윤홍 on 8/28/24.
//

import UIKit

class SearchView: UIView {
  
  private let topView: UIView = {
    let uiView = UIView()
    return uiView
  }()
  
  private let tabBarName: UILabel = {
    let label = UILabel()
    label.text = "검색"
    label.font = .boldSystemFont(ofSize: 30)
    return label
  }()
  
  let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "친구를 검색해보세요!"
    return searchBar
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureUI() {
    topView.addSubview(tabBarName)
    self.addSubview(topView)
    self.addSubview(searchBar)
  }
  
  func setConstraints() {
    topView.snp.makeConstraints {
      $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
      $0.height.equalTo(100)
    }
    
    tabBarName.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview()
    }
    
    searchBar.snp.makeConstraints {
      $0.top.equalTo(topView.snp.bottom).offset(200)
      $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
    }
  }
}
