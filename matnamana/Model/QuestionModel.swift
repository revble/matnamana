//
//  QuestionModel.swift
//  matnamana
//
//  Created by 김윤홍 on 8/27/24.
//

struct Question: Codable {
//  let questionId: String
  let contents: [Content]
}

extension Question {
  struct Content: Codable {
//    let contentType: QuestionType
    let contentType: String
    let contentDescription: String
  }
}

//extension Question.Content {
//  enum QuestionType: String, Codable {
//    case fact
//    case career
//    case values
//  }
//}
