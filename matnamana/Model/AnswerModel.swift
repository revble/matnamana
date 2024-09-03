//
//  AnswerModel.swift
//  matnamana
//
//  Created by 김윤홍 on 8/29/24.
//

import Foundation

struct Answer: Codable {
  let answerId: String
  let requestId: String
  let questionId: String
  let responderId: String
  let answerText: String
  let createdAt: Date
}
