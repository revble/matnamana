//
//  ViewController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/22/24.
//

import UIKit

class TabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewConfig()
  }
  
  private func viewConfig() {
    let viewControllers = TabbarItem.allCases.map { item -> UINavigationController in
      let vc = item.viewController
      vc.view.backgroundColor = .systemBackground
      vc.navigationItem.title = item.navigtaionItemTitle
      let nav = UINavigationController(rootViewController: vc)
      nav.title = item.navigtaionItemTitle
      nav.tabBarItem.image = UIImage(systemName: item.tabbarImageName)
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
    case profile
    
    var viewController: UIViewController {
      switch self {
      case .mainPage:
        return MainQuestionViewController()
      case .friendList:
        return FriendListController()
      case .reputation:
        return ReputaionController()
      case .profile:
        return ProfileController()
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
      case .profile:
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
        return "평판 조회"
      case .profile:
        return "나의 정보"
      }
    }
  }
}
