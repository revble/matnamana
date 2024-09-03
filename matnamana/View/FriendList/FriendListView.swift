//
//  FriendListView.swift
//  matnamana
//
//  Created by 김윤홍 on 8/27/24.
//

import UIKit

import SnapKit
import Then

final class FriendListView: UIView {
  
  private let friendCount = UILabel().then {
    $0.text = ""
  }
  
  let addFriend = UIButton(type: .system).then {
    let image = UIImage(systemName: "person.badge.plus")
    $0.setImage(image, for: .normal)
    $0.imageView?.contentMode = .scaleAspectFit
    $0.setTitle("", for: .normal)
  }
  
  let searchBar = UISearchBar().then {
    $0.placeholder = "친구를 검색해보세요!"
  }
  
  let friendList = UITableView(frame: .zero, style: .insetGrouped).then {
    $0.register(FriendListCell.self,
                forCellReuseIdentifier: FriendListCell.identifier)
    $0.rowHeight = 100
  }
  
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
      searchBar,
      friendList
    ].forEach { self.addSubview($0) }
  }
  
  func setConstraints() {
    
    searchBar.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide)
      $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
    }
    
    friendList.snp.makeConstraints {
      $0.top.equalTo(searchBar.snp.bottom)
      $0.bottom.equalTo(self.safeAreaLayoutGuide)
      $0.horizontalEdges.equalToSuperview()
    }
  }
}

