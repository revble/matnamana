//
//  AnswerListController.swift
//  matnamana
//
//  Created by pc on 9/17/24.
//

import UIKit

import RxCocoa
import RxSwift

final class AnswerListController: BaseViewController {
  private let viewModel = AnswerListViewModel()
  private var answerListView = AnswerListView(frame: .zero)
  
  private var nickName: String
  private var requester: String
  private var target: String
  
  init(nickName: String, requester: String, target: String) {
    self.nickName = nickName
    self.requester = requester
    self.target = target
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.fetchFriendList(requester: requester, target: target)

  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

  }
  
  override func setupView() {
    super.setupView()
    answerListView = AnswerListView(frame: UIScreen.main.bounds)
    self.view = answerListView
    self.navigationItem.title = "답변확인"
  }
  
  override func bind() {
    super.bind()
    
    
    
    viewModel.reputationRequest
      .bind(to: answerListView.tableView.rx.items(cellIdentifier: String(describing: AnswerListCell.self), cellType: AnswerListCell.self)) { row, reputation, cell in
        cell.configure(with: reputation)
      }.disposed(by: disposeBag)
    
    answerListView.tableView.rx.itemSelected
      .subscribe { [weak self] indexPath in
        guard let self else { return }
        if let cell = self.answerListView.tableView.cellForRow(at: indexPath) as? AnswerListCell {
          let nickName = cell.userName.text ?? ""
          pushViewController(ReadAnserController(name: nickName, requester: requester, target: target))
        }

      }.disposed(by: disposeBag)
  }
  
}
