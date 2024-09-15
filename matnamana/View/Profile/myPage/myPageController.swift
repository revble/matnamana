//
//  myPageController.swift
//  matnamana
//
//  Created by 이진규 on 9/13/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class myPageController: BaseViewController {
  let myPageTable = ["나의 히스토리", "공지", "자주 묻는 질문", "맞나만나에 문의하기", "맞나만나 정보"]

  var myPageView = MyPageView(frame: .zero)
  
  override func setupView() {
    super.setupView()
    myPageView = MyPageView(frame: UIScreen.main.bounds)
    self.view = myPageView
  }
  override func bind() {
    super.bind()
    bindTableView()

    myPageView.myPageButton.rx.tap
      .subscribe(onNext: { [weak self] in
        guard let self else { return }
        self.navigationController?.pushViewController(ProfileController(), animated: true)
      }).disposed(by: disposeBag)
  }

  private func bindTableView() {
    myPageView.tableView.dataSource = self
    myPageView.tableView.delegate = self
  }
}

extension myPageController: UITableViewDataSource, UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    switch indexPath.row {
    case 1:
      if let url = URL(string: "https://matnamana.com") {  UIApplication.shared.open(url, options: [:])
      }
    case 2:
      if let url = URL(string: "https://matnamana.com") {  UIApplication.shared.open(url, options: [:])
      }
    case 3:
      if let url = URL(string: "https://matnamana.com") {  UIApplication.shared.open(url, options: [:])
      }
    case 4:
      if let url = URL(string: "https://matnamana.com") {  UIApplication.shared.open(url, options: [:])
      }
    default:
      print(indexPath.row)
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    myPageTable.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: myPageCell.self), for: indexPath) as? myPageCell else {
      return UITableViewCell()
    }

    let cellText = myPageTable[indexPath.row]
    cell.configureCell(myPageCell: cellText) // 셀에 텍스트 설정
    return cell
  }
}
