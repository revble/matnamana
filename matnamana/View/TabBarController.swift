//
//  ViewController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/22/24.
//

import UIKit

final class TabBarController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    viewConfig()
    guard let userId = UserDefaults.standard.string(forKey: "loggedInUserId") else { return }
    FirebaseManager.shared.readUser(documentId: userId) { user, error in
      if error != nil {
        return
      } else if let user = user {
        let myNickName = user.info.nickName
        let myName = user.info.name
        UserDefaults.standard.setValue(myNickName, forKey: "userNickName")
        UserDefaults.standard.setValue(myName, forKey: "userName")
        UserDefaults.standard.setValue("profile", forKey: "userImage")
        self.navigationItem.largeTitleDisplayMode = .always
      }
    }
  }
  
  private func viewConfig() {
      let viewControllers = TabbarItem.allCases.map { item -> UINavigationController in
          let vc = item.viewController
          vc.view.backgroundColor = .systemBackground
          vc.navigationItem.title = item.navigtaionItemTitle
          vc.navigationItem.largeTitleDisplayMode = .always

          let nav = UINavigationController(rootViewController: vc)
          nav.title = item.navigtaionItemTitle
          nav.tabBarItem.image = UIImage(systemName: item.tabbarImageName)

          // Large Title 설정
          nav.navigationBar.prefersLargeTitles = true

          return nav
      }
      setViewControllers(viewControllers, animated: false)
  }

}
extension TabBarController {
  
  enum TabbarItem: CaseIterable {
    case mainPage
    case friendList
    case reputation
    case myPage

    var viewController: UIViewController {
      switch self {
      case .mainPage:
        return MainQuestionViewController()
      case .friendList:
        return FriendListController()
      case .reputation:
        let viewModel = AcceptRequestViewModel()
        return ReputaionController(acceptViewModel: viewModel)
      case .myPage:
        return myPageController()
      }
    }
    
    var tabbarImageName: String {
      switch self {
      case .mainPage:
        return "house.fill"
      case .friendList:
        return "person.2.fill"
      case .reputation:
        return "list.bullet.rectangle.portrait.fill"
      case .myPage:
        return "person.fill"
      }
    }
    
    var navigtaionItemTitle: String {
      switch self {
      case .mainPage:
        return "홈"
      case .friendList:
        return "친구 목록"
      case .reputation:
        return "맞나만나"
      case .myPage:
        return "마이페이지"
      }
    }
  }
}
