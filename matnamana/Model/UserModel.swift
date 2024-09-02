////
////  UserModel.swift
////  matnamana
////
////  Created by 김윤홍 on 8/27/24.
////

struct User: Codable {
  let info: Info
  let preset: [PresetQuestion]
  let friendList: [Friend]
  let userId: String
}

extension User {
  struct Info: Codable {
    //let mbti: String
    let career: String
    let education: String
    let email: String
    let location: String
    let name: String
    let phoneNumber: String
    let shortDescription: String
    let profileImage: String
    let nickname: String
  }
  
  struct PresetQuestion: Codable {
    let presetTitle: String
    let indice: [Int] // 사용자가 미리 정의된 목록에서 선택한 질문의 인덱스
  }
  
  struct Friend: Codable {
    let nickname: String
    let type: FriendType
    let friendId: String
  }
}

extension User.Friend {
  enum FriendType: String, Codable {
    case family
    case colleague
    case friend
  }
}
