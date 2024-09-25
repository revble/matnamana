//
//  ReferenceCheckController.swift
//  matnamana
//
//  Created by 김윤홍 on 9/6/24.
//

import UIKit

import RxCocoa
import RxSwift

final class ReferenceCheckController: BaseViewController {
  
  private var referenceView = ReferenceView(frame: .zero)
  private var viewModel = ReferenceViewModel()
  private var targetID: String
  private var questions: [String]
  private var presetTitle: String
  private var mannamQuestion = [QuestionList(answer: ["" : ""], contentDescription: "")]
  
  init(targetId: String, questions: [String], presetTitle: String) {
    self.targetID = targetId
    self.questions = questions
    self.presetTitle = presetTitle
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var request = ReputationRequest(
    requester: UserProfile(nickName: "",
                           profileImage: "",
                           userId: ""),
    target: UserProfile(nickName: "",
                        profileImage: "",
                        userId: ""),
    questionList: [],
    status: .pending,
    selectedFriends: [],
    selectedFriendsUserIds: []
  )
  
  override func setupView() {
    super.setupView()
    referenceView = ReferenceView(frame: UIScreen.main.bounds)
    self.view = referenceView
    
    referenceView.customTable.delegate = self
    referenceView.customTable.dataSource = self
    referenceView.questionTitle.text = presetTitle
  }
  
  override func bind() {
    super.bind()
    
    referenceView.sendButton.rx.tap
      .subscribe({ [weak self] _ in
        guard let self else { return }
        let alert = UIAlertController(title: "평판조회가 신청되었습니다.", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
          self.navigationController?.popToRootViewController(animated: true)
        }))
        self.present(alert, animated: true)
    
        guard let requestId = UserDefaults.standard.string(forKey: "loggedInUserId") else { return }
        guard let userName = UserDefaults.standard.string(forKey: "userName") else { return }
        guard let userImage = UserDefaults.standard.string(forKey: "userImage") else { return }
        FirebaseManager.shared.getUserInfo(nickName: targetID) { [weak self] snapShot, error in
          guard let snapShot = snapShot else { return }
          guard let self else { return }
          
//          for question in self.questions {
//              let newQuestion = QuestionList(answer: ["a": "b"], contentDescription: question)
//              mannamQuestion.append(newQuestion)
//          }
          let newQuestion = questions.map {
            QuestionList(answer: nil, contentDescription: $0)
          }
          self.request = ReputationRequest(
            requester: UserProfile(nickName: userName, profileImage: userImage, userId: requestId),
            target: UserProfile(nickName: snapShot.info.name, profileImage: userImage, userId: snapShot.userId),
            questionList: newQuestion,
            status: .pending,
            selectedFriends: [UserProfile(nickName: "", profileImage: "", userId: "")],
            selectedFriendsUserIds: [""]
          )
          print(self.request)
          FirebaseManager.shared.addData(to: .reputationRequest,
                                         data: request,
                                         documentId: requestId + "-" + snapShot.userId
          )
        }
      }).disposed(by: disposeBag)
  }
}

extension ReferenceCheckController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = referenceView.customTable.dequeueReusableCell(withIdentifier: String(describing: ReputationListCell.self), for: indexPath) as? ReputationListCell else { return UITableViewCell() }
    cell.configure(text: self.questions[indexPath.row])
    print(self.questions[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
}
