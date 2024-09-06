//
//  SectionModel.swift
//  matnamana
//
//  Created by pc on 9/2/24.
//

import RxDataSources

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
  let id: Int
  let title: String
}

