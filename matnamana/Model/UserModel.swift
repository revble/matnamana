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
//  let reputationId: String
}

extension User {
  struct Info: Codable {
    let career: String
    let education: String
    let email: String
    let location: String
    let name: String
    let phoneNumber: String
    let shortDescription: String
    let profileImage: String
    let nickName: String
  }
  
  struct PresetQuestion: Codable {
    let presetTitle: String
    let indice: [Int]
  }
  
  struct Friend: Codable {
    let nickname: String
    let type: FriendType
    let friendId: String
    let friendImage: String
  }
}

extension User.Friend {
  enum FriendType: String, Codable {
    case family
    case colleague
    case friend
  }
}
