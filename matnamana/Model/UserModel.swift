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
    let career: String //직업
    let education: String //최종학력
    let email: String //이메일
    let location: String //거주지
    let name: String //이름
    let phoneNumber: String//휴대번호
    let shortDescription: String// 자기소개
    let profileImage: String//사진
    let nickName: String//별명
    let birth: String //추가 생년월일
    let university: String //추가 대학교
    let companyName: String //추가 회사명

  }
  
  struct PresetQuestion: Codable {
    let presetTitle: String
    let indice: [Int] // 사용자가 미리 정의된 목록에서 선택한 질문의 인덱스
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
