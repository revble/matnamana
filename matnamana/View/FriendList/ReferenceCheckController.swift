//////
//////  ReferenceCheckController.swift
//////  matnamana
//////
//////  Created by 김윤홍 on 9/6/24.
//////
////
////import UIKit
////
////import RxCocoa
////import RxSwift
////
//
//import UIKit
//
//import RxCocoa
//import RxSwift
//
//final class ReferenceCheckController: BaseViewController {
//  
//  private var referenceView = ReferenceView(frame: .zero)
//  private var viewModel = ReferenceViewModel()
//  private var targetID: String
//  
//  init(targetId: String) {
//    self.targetID = targetId
//    super.init(nibName: nil, bundle: nil)
//  }
//  
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//  
//  var request = ReputationRequest(
//    requester: UserProfile(nickName: "", profileImage: "", userId: ""),
//    target: UserProfile(nickName: "", profileImage: "", userId: ""),
//    questionList: [Question.Content](),
//    status: .pending,
//    selectedFriends: []
//  )
//  
//  override func setupView() {
//    super.setupView()
//    referenceView = ReferenceView(frame: UIScreen.main.bounds)
//    self.view = referenceView
//  }
//  
//  override func bind() {
//    super.bind()
//    let input = ReferenceViewModel.Input(fetchQuestions: Observable.just(()),
//                                         buttonInput: referenceView.sendButton.rx.tap)
//    let output = viewModel.transform(input: input)
//    
//    referenceView.sendButton.rx.tap
//      .subscribe({ [weak self] _ in
//        guard let self else { return }
//        
//        FirebaseManager.shared.addData(to: .reputationRequest,
//                                       data: request,
//                                       documentId: request.requestId
//        )
//        let alert = UIAlertController(title: "평판조회가 신청되었습니다.", message: nil, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
//          self.navigationController?.popToRootViewController(animated: true)
//        }))
//        self.present(alert, animated: true)
//      }).disposed(by: disposeBag)
//    
//    output.questionList
//      .drive(onNext: { [weak self] question in
//        guard let self else { return }
//        for (index, content) in question.enumerated() {
//          if index < self.referenceView.questions.count {
//            self.referenceView.questions[index].text = content.contentDescription
//          }
//        }
//        
//        guard let requestId = UserDefaults.standard.string(forKey: "loggedInUserId") else { return }
//        
//        request = ReputationRequest(
//          requestId: requestId,
//          requesterId: requestId,
//          targetId: targetID,
//          questionList: question,
//          status: .pending,
//          selectedFriends: []
//        )
//      })
//      .disposed(by: disposeBag)
//  }
//}
