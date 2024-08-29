//
//  QuestionModel.swift
//  matnamana
//
//  Created by 김윤홍 on 8/27/24.
//

struct Question {
  let questionId: String
  let contents: [Content]
}

extension Question {
  struct Content {
    let contentType: QuestionType
    let contentDescription: String
  }
}

extension Question.Content {
  enum QuestionType: String {
    case fact
    case career
    case values
  }
}
