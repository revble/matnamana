//
//  ReadAnserController.swift
//  matnamana
//
//  Created by pc on 9/14/24.
//

import UIKit

import RxCocoa
import RxSwift

final class ReadAnserController: BaseViewController {
//  
  private var name: String
  private var requester: String
  private var target: String
  private var userId: String?
  
  private var viewModel = ReadAnswerViewModel()
  private var readAnswerView = ReadAnswerView(frame: .zero)
  
  init(name: String, requester:String, target: String) {
    self.name = name
    self.requester = requester
    self.target = target
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.fetchQandA(requester: requester, target: target)

  }
  
  override func bind() {
    super.bind()
    
    viewModel.questionListRelay
      .bind(to: readAnswerView.tableVIew.rx.items(cellIdentifier: String(describing: QandACell.self), cellType: QandACell.self)) { [weak self] row, question, cell in
        guard let self else { return }
        self.viewModel.readFriendId(nickName: name) { documentId, error in
          cell.configure(with: question, userId: documentId)
        }
      }.disposed(by: disposeBag)
  }
  
  override func setupView() {
    super.setupView()
    readAnswerView = ReadAnswerView(frame: UIScreen.main.bounds)
    self.view = readAnswerView
    
    readAnswerView.reName(name: name)
  }
  
}
