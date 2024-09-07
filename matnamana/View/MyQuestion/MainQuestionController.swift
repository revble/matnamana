//
//  MainQuestionController.swift
//  matnamana
//
//  Created by 김윤홍 on 9/7/24.
//

import UIKit

import RxCocoa
import RxSwift

class MainQuestionViewController: BaseViewController {
  
  private var mainQuestionView = MainQuestionView(frame: .zero)
  private let viewModel = MainQuestionViewModel()
  
  override func setupView() {
    mainQuestionView = MainQuestionView(frame: UIScreen.main.bounds)
    self.view = mainQuestionView
  }
  
  override func setNavigation() {
    super.setNavigation()
    self.title = "matnamana"
  }
  
  override func bind() {
    super.bind()
    let input = MainQuestionViewModel.Input(
      totalListButtonTap: mainQuestionView.totalListButton.rx.tap.asObservable()
    )
    
    let output = viewModel.transform(input: input)
    
    output.moveTotalList
      .drive(onNext: { [weak self] in
        guard let self = self else { return }
        self.navigationController?.pushViewController(TotalQuestionController(), animated: true)
      }).disposed(by: disposeBag)
    
    output.questionItems
      .drive(mainQuestionView.questionCollection.rx
        .items(cellIdentifier: MainCollectionCell.identifier, cellType: MainCollectionCell.self)) { index, item, cell in
          cell.titleLabel.text = DocumentModel.translateKorean(item)
          cell.titleLabel.textColor = .black
          cell.titleLabel.frame = cell.contentView.bounds
          cell.contentView.backgroundColor = .manaSkin
        }.disposed(by: disposeBag)
    
    mainQuestionView.questionCollection.rx.itemSelected
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] indexPath in
        guard let self = self else { return }
        if let cell = self.mainQuestionView.questionCollection.cellForItem(at: indexPath) as? MainCollectionCell {
          let title = cell.titleLabel.text
          let documentId = DocumentModel.translateEnglish(cell.titleLabel.text ?? "")
          self.movePage(documentId: documentId, title: title ?? "")
        }
      }).disposed(by: disposeBag)
  }
  
  private func movePage(documentId: String, title: String) {
    let viewModel = TypeQuestionViewModel(questionId: documentId)
    let vc = TypeQuestionController(viewModel: viewModel, title: title)
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

