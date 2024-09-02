//
//  File.swift
//  matnamana
//
//  Created by 김윤홍 on 8/29/24.
//

struct ReputationRequest: Codable {
  let requestId: String
  let requesterId: String
  let targetId: String
  let questionList: [Question.Content]
  let status: RequestStatus
  let selectedFriends: [User.Friend]
}

extension ReputationRequest {
  enum RequestStatus: String, Codable {
    case pending
    case approved
    case rejected
  }
}
