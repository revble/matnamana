//
//  Protocol.swift
//  matnamana
//
//  Created by 김윤홍 on 9/4/24.
//

protocol ViewModelType {
  associatedtype Input
  associatedtype Output
  
  func transform(input: Input) -> Output
}
