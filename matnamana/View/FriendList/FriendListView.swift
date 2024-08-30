//
//  FriendListView.swift
//  matnamana
//
//  Created by 김윤홍 on 8/27/24.
//

import UIKit

import SnapKit

class FriendListView: UIView {
  
  private let topView: UIView = {
    let uiView = UIView()
    return uiView
  }()
  
  private let tabBarName: UILabel = {
    let label = UILabel()
    label.text = "친구목록"
    label.font = .boldSystemFont(ofSize: 30)
    return label
  }()
  
  private let friendCount: UILabel = {
    let label = UILabel()
    label.text = ""
    return label
  }()
  
  let addFriend: UIButton = {
    let button = UIButton(type: .system)
    let image = UIImage(systemName: "person.badge.plus")
    button.setImage(image, for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    button.setTitle("", for: .normal)
    return button
  }()
  
  let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "친구를 검색해보세요!"
    return searchBar
  }()
  
  let friendList: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .gray
    return tableView
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
    [
      tabBarName,
      friendCount,
      addFriend
    ].forEach { topView.addSubview($0) }
    
    [
      topView,
      searchBar,
      friendList
    ].forEach { self.addSubview($0) }
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
    
    friendCount.snp.makeConstraints {
      $0.leading.equalTo(tabBarName.snp.trailing)
      $0.centerY.equalToSuperview()
    }
    
    addFriend.snp.makeConstraints {
      $0.trailing.equalToSuperview()
      $0.centerY.equalToSuperview()
      $0.width.height.equalTo(50)
    }
    
    searchBar.snp.makeConstraints {
      $0.top.equalTo(topView.snp.bottom)
      $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
    }
    
    friendList.snp.makeConstraints {
      $0.top.equalTo(searchBar.snp.bottom)
      $0.bottom.equalTo(self.safeAreaLayoutGuide)
      $0.horizontalEdges.equalToSuperview()
    }
  }
}

