////
////  UserModel.swift
////  matnamana
////
////  Created by 김윤홍 on 8/27/24.
////
//
//struct User {
//  let info: Info
//  let preset: [PresetQuestion]
//  let friendList: [Friend]
//}
//
//extension User {
//  struct Info {
//    let mbti: String
//    let career: String
//    let education: String
//    let email: String
//    let location: String
//    let name: String
//    let phoneNumber: String
//    let shortDescription: String
//    let profileImage: String
//  }
//
//  struct PresetQuestion {
//    let presetTitle: String
//    let indice: [Int]
//  }
//
//  struct Friend {
//    let nickname: String
//    let type: FriendType
//  }
//}
//
//extension User.Friend {
//  enum FriendType {
//    case family
//    case collegue
//    case friend
//  }
//}
//
//
import Foundation

struct User {
  let info: Info
  let preset: [PresetQuestion]
  let friendList: [Friend]
  let userId: String // Firebase userId
}

extension User {
  struct Info {
    let mbti: String
    let career: String
    let education: String
    let email: String
    let location: String
    let name: String
    let phoneNumber: String
    let shortDescription: String
    let profileImage: String
  }
  
  struct PresetQuestion {
    let presetTitle: String
    let indice: [Int] // 사용자가 미리 정의된 목록에서 선택한 질문의 인덱스
  }
  
  struct Friend {
    let nickname: String
    let type: FriendType
    let friendId: String // 친구의 Firebase userId
  }
}

extension User.Friend {
  enum FriendType: String {
    case family
    case colleague
    case friend
  }
}

struct ReputationRequest {
  let requestId: String
  let requesterId: String // 요청자의 userId (예: 김민지)
  let targetId: String // 대상자의 userId (예: 박동현)
  let questionList: [Question.Content]
  let status: RequestStatus
  let selectedFriends: [User.Friend] // 답변을 제공할 친구들
}

extension ReputationRequest {
  enum RequestStatus: String {
    case pending
    case approved
    case rejected
  }
}

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

struct Answer {
  let answerId: String
  let requestId: String // ReputationRequest와 연결됨
  let questionId: String // Question과 연결됨
  let responderId: String // 답변자의 userId
  let answerText: String
  let createdAt: Date
}
