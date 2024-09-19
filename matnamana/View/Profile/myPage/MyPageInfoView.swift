//
//  MyPageInfo.swift
//  matnamana
//
//  Created by 이진규 on 9/19/24.
//

import UIKit

import SnapKit
import Then

final class MyPageInfoView: BaseView{
  
  let tableView = UITableView().then {
    $0.register(MypageInfoCell.self, forCellReuseIdentifier: String(describing: MypageInfoCell.self))
    $0.rowHeight = 48
  }
  
  override func configureUI() {
    [tableView].forEach { self.addSubview($0) }
  }
  
  override func setConstraints() {
    tableView.snp.makeConstraints{
      $0.top.equalTo(safeAreaLayoutGuide).offset(18)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(self.safeAreaLayoutGuide)
      
    }
  }
}

