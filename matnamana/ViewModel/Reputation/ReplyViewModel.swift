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
      if error != nil {
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
    let answers: [(String, String)] = answerDataRelay.value
    let reputationRequest = db.collection("reputationRequests").document(documentId)
    reputationRequest.getDocument { snapshot, error in
      
      guard let document = try? snapshot?.data(as: ReputationRequest.self) else { return }
      
//      var updatedQuestionList = document.questionList
//      var a = 0
//      for (question, answer) in answers {
//        updatedQuestionList[a].answer![userId] = answer
//        a += 1
//      }
//      reputationRequest.updateData(["questionList": updatedQuestionList])
      
      let updatedData: [String: Any] = [
        "questionList": answers.map { answerTuple in
          [
            "contentDescription": answerTuple.0,
            "answer": [
              userId: answerTuple.1,
              document.questionList[0].answer?.keys.first: document.questionList[0].answer?.values.first
            ]
          ]
        }
      ]
      reputationRequest.setData(updatedData, merge: true)
    }
    
    
//    let updatedData: [String: Any] = [
//      "questionList": answers.map { answerTuple in
//        [
//          "contentDescription": answerTuple.0,
//          "answer": [
//            userId: answerTuple.1
//          ]
//        ]
//      } 
//    ]
//    
//    reputationRequest.setData(updatedData, merge: true)
    
  }
  
  
  func saveAnswer(question: String, answer: String) {
    answers.append((question, answer))
    if answers.count == 5 {
      answerDataRelay.accept(answers)
    }
  }
}
