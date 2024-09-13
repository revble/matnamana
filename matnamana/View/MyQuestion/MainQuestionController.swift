//
//  MainQuestionController.swift
//  matnamana
//
//  Created by 김윤홍 on 9/7/24.
//

import UIKit

import RxCocoa
import RxSwift

final class MainQuestionViewController: BaseViewController {
  
  private var mainQuestionView = MainQuestionView(frame: .zero)
  private let viewModel = MainQuestionViewModel()
  
  override func setupView() {
    super.setupView()
    mainQuestionView = MainQuestionView(frame: UIScreen.main.bounds)
    self.view = mainQuestionView
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
  }
  
  // 컬렉션 뷰 설정
  private func setupCollectionView() {
    mainQuestionView.mainCollection.delegate = self
    mainQuestionView.mainCollection.dataSource = self
  }
  
  //  override func bind() {
  //    super.bind()
  //    let input = MainQuestionViewModel.Input(
  //      totalListButtonTap: mainQuestionView.totalListButton.rx.tap.asObservable()
  //    )
  //    
  //    let output = viewModel.transform(input: input)
  //    
  //    output.moveTotalList
  //      .drive(onNext: { [weak self] in
  //        guard let self else { return }
  //        self.navigationController?.pushViewController(TotalQuestionController(), animated: true)
  //      }).disposed(by: disposeBag)
  //    
  //    output.questionItems
  //      .drive(mainQuestionView.questionCollection.rx
  //        .items(cellIdentifier: MainCollectionCell.identifier, cellType: MainCollectionCell.self)) { index, item, cell in
  //          cell.titleLabel.text = DocumentModel.translateKorean(item)
  //          cell.titleLabel.textColor = .black
  //          cell.titleLabel.frame = cell.contentView.bounds
  //          cell.contentView.backgroundColor = .manaSkin
  //        }.disposed(by: disposeBag)
  //    
  //    mainQuestionView.questionCollection.rx.itemSelected
  //      .observe(on: MainScheduler.instance)
  //      .subscribe(onNext: { [weak self] indexPath in
  //        guard let self else { return }
  //        if let cell = self.mainQuestionView.questionCollection.cellForItem(at: indexPath) as? MainCollectionCell {
  //          let title = cell.titleLabel.text
  //          let documentId = DocumentModel.translateEnglish(cell.titleLabel.text ?? "")
  //          self.movePage(documentId: documentId, title: title ?? "")
  //        }
  //      }).disposed(by: disposeBag)
  //  }
  //  
  //  private func movePage(documentId: String, title: String) {
  //    let viewModel = TypeQuestionViewModel(questionId: documentId)
  //    let vc = TypeQuestionController(viewModel: viewModel, title: title)
  //    self.navigationController?.pushViewController(vc, animated: true)
  //  }
}
extension MainQuestionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.section {
    case 0:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BannerCell.self), for: indexPath) as? BannerCell else { return UICollectionViewCell() }
      cell.configure(with: UIImage(named: "exampleImage") ?? UIImage())
      return cell
    case 1:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: QuestionCell.self), for: indexPath) as? QuestionCell else { return UICollectionViewCell() }
      return cell
    case 2:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CustomQuestionCell.self), for: indexPath) as? CustomQuestionCell else { return UICollectionViewCell() }
      cell.configure(with: "Custom Question")
      return cell
    default:
      fatalError("default cell")
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard kind == UICollectionView.elementKindSectionHeader, indexPath.section == 2 else {
      return UICollectionReusableView()
    }
    
    guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: HeaderView.self), for: indexPath) as? HeaderView else { return UICollectionReusableView() }
    header.configure(with: "나만의 질문")
    return header
  }
}
