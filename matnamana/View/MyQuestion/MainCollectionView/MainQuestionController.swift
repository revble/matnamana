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
  private var presetTitles = [String]()
  private var presetQuestions = [User.PresetQuestion]()
  
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
  
  func bindCell(cell: QuestionCell) {
    let input = MainQuestionViewModel.Input(
      totalButtonTap: cell.totalButtonTap,
      coupleButtonTap: cell.coupleButtonTap,
      simpleMannamButtonTap: cell.simpleMannamButtonTap,
      businessButtonTap: cell.businessButtonTap,
      fetchQuestions: Observable.just(())
    )
    
    let output = viewModel.transform(input: input)
    
    output.presetTitles
      .drive(onNext: { [weak self] titles in
        print(titles)
        self?.presetTitles = titles
        self?.mainQuestionView.mainCollection.reloadSections(IndexSet(integer: 2))
      })
      .disposed(by: disposeBag)
    
    output.presetQuestions
      .drive(onNext: { [weak self] questions in
        self?.presetQuestions = questions
        print(questions)
        self?.mainQuestionView.mainCollection.reloadSections(IndexSet(integer: 2))
      })
      .disposed(by: disposeBag)
    
    
    output.navigateTo
      .subscribe(onNext: { [weak self] destination in
        guard let self else { return }
        
        let vc: UIViewController
        
        switch destination {
        case .totalQuestion:
          vc = TotalQuestionController(isCustom: false)
        case .coupleQuestion:
          let viewModel = TypeQuestionViewModel(questionId: "BestMeeting")
          vc = TypeQuestionController(viewModel: viewModel, title: "연애 질문")
          
        case .simpleMannam:
          let viewModel = TypeQuestionViewModel(questionId: "IceBreaking")
          vc = TypeQuestionController(viewModel: viewModel, title: "느슨한 만남")
          
        case .business:
          let viewModel = TypeQuestionViewModel(questionId: "BestCoworker")
          vc = TypeQuestionController(viewModel: viewModel, title: "비즈니스")
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
      })
      .disposed(by: disposeBag)
  }
  
  override func bind() {
    super.bind()
  }
}

extension MainQuestionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if indexPath.section == 0 && indexPath.item == 0 {
      if let url = URL(string: "https://teaminpact.com/projects/") {    UIApplication.shared.open(url, options: [:])
      }
    }
    
    if indexPath.section == 2 {
      let selectedQuestion = presetQuestions[indexPath.row]
      let viewModel = CustomQuestionViewModel(presetQuestions: selectedQuestion.presetQuestion)
      let vc = CustomQuestionController(viewModel: viewModel, presetTitle: selectedQuestion.presetTitle)
      navigationController?.pushViewController(vc, animated: true)
    }
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0, 1:
      return 1
    case 2:
      return presetTitles.count
    default:
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.section {
    case 0:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BannerCell.self), for: indexPath) as? BannerCell else { return UICollectionViewCell() }
      return cell
    case 1:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: QuestionCell.self), for: indexPath) as? QuestionCell else { return UICollectionViewCell() }
      bindCell(cell: cell)
      return cell
    case 2:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CustomQuestionCell.self), for: indexPath) as? CustomQuestionCell else { return UICollectionViewCell() }
      cell.configure(title: presetTitles[indexPath.row])
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
