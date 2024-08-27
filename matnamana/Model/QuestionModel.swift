//
//  QuestionModel.swift
//  matnamana
//
//  Created by 김윤홍 on 8/27/24.
//

struct question {
  let contents: [content]
}

extension question {
  struct content {
    let contenType: questionType
    let contentDescription: String
  }
}

extension question.content {
  enum questionType {
    case fact
    case career
    case values
  }
}
