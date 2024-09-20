//
//  File.swift
//  matnamana
//
//  Created by 김윤홍 on 8/29/24.
//

struct ReputationRequest: Codable {
  let requester: UserProfile?
  let target: UserProfile?
  let questionList: [Question.Content]?
  let status: String?
  let selectedFriends: [UserProfile]?
  let selectedFriendsUserIds: [String]?
}

struct UserProfile: Codable {
  let nickName: String?
  let profileImage: String?
  let userId: String?
}
