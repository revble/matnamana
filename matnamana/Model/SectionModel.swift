//
//  SectionModel.swift
//  matnamana
//
//  Created by pc on 9/2/24.
//


enum Section: Int, CaseIterable {
  case friendRequest
  case myRequests
  case receivedRequests
  
  var title: String {
    switch self {
    case .friendRequest: return "친구 평판조회"
    case .myRequests: return "요청한 평판조회"
    case .receivedRequests: return "요청받은 평판조회"
    }
  }
}

struct Item {
  let userNickName: String
  let profileImageUrl: String
  let requesterId: String
  let targetId: String
  
    self.userNickName = userNickName
    self.profileImageUrl = profileImageUrl
    self.requesterId = requesterId
    self.targetId = targetId
  }
  
}


struct FriendsSection {
  var header: String
  var items: [User.Friend]
}

extension FriendsSection: SectionModelType {
  typealias Item = User.Friend
  
  init(original: FriendsSection, items: [User.Friend]) {
    self = original
    self.items = items
  }
}
