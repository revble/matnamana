//
//  ReplyViewModel.swift
//  matnamana
//
//  Created by pc on 9/12/24.
//

import Foundation

import FirebaseFirestore
import RxCocoa
import RxSwift


final class ReplyViewModel {
  
  private let db = FirebaseManager.shared.db
  
  var questionDataRelay = BehaviorRelay(value: [String]())
  
  var answerDataRelay = BehaviorRelay(value: [(String, String)]())
  
  var answers = [(question: String, answer: String)]()
  
  func fetchQuestionList(nickName: String) {
    guard let userId = UserDefaults.standard.string(forKey: "loggedInUserId") else { return }
    FirebaseManager.shared.fetchquestionList(userId: userId, targetNickName: nickName) { reputationRequests, error in
      if let error = error {
        print("error")
      }
      guard let reputationRequests else { return }
      
      var questionData: [String] = []
      
      for reputationRequest in reputationRequests {
        
        let questionList = reputationRequest.questionList
        
        for question in questionList {
          let contentDescription = String(question.contentDescription)
          
          questionData.append(contentDescription)
          
        }
      }
      self.questionDataRelay.accept(questionData)
    }
  }
  func sendAnswers(requester: String, target: String) {
    guard let userId = UserDefaults.standard.string(forKey: "loggedInUserId") else { return }
    let documentId = "\(requester)-\(target)"

    let reputationRequest = db.collection("reputationRequests").document(documentId)
    
    let answers = answerDataRelay.value
  
    let updatedData: [String: Any] = [
      "questionList": answers.map { answerTuple in
        [
          "contentType": "",
          "contentDescription": answerTuple.0,
          "answer": [
            userId: answerTuple.1
          ]
        ]
      }
    ]
    do {
      try reputationRequest.updateData(updatedData)
      print("Document successfully updated")
    } catch {
      print("Error updating document: \(error)")
    }
    
  }
  
  
  func saveAnswer(question: String, answer: String) {
    answers.append((question, answer))
    if answers.count == 5 {
      answerDataRelay.accept(answers)
    }
  }
}
