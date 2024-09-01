//
//  RequiredInformaitionViewModel.swift
//  matnamana
////
////  Created by pc on 8/30/24.
////
//
//import Foundation
//
//import FirebaseAuth
//import FirebaseCore
//import FirebaseFirestore
//import RxSwift
//import RxCocoa
//
//class RequiredInformaitionViewModel {
//  private func makeUserInformation() {
//    guard let appleUser = Auth.auth().currentUser else { return }
//    let user = User(
//        info: User.Info(
//            career: "",
//            education: "",
//            email: "",
//            location: "",
//            name: requiredInformationView.pickName(),
//            phoneNumber: "",
//            shortDescription: "",
//            profileImage: "",
//            nickname: requiredInformationView.pickNickname()
//        ),
//        preset: [],
//        friendList: [],
//        userId: appleUser.uid,
//        reputationId: ""
//    )
//    FirebaseManager.shared.addUser(user: user)
//  }
//}
