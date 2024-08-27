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
    view.backgroundColor = .systemBackground
  
    let firstVC = LoginController()
    firstVC.tabBarItem = UITabBarItem(title: "로그인", image: UIImage(systemName: "globe"), tag: 0)
    
    let secondVC = MainPageController()
    secondVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house.fill"), tag: 1)
    
    let thirdVC = FriendListController()
    thirdVC.tabBarItem = UITabBarItem(title: "친구 목록", image: UIImage(systemName: "person.2.fill"), tag: 2)
    
    let fourthVC = myQuestionController()
    fourthVC.tabBarItem = UITabBarItem(title: "나의 질문", image: UIImage(systemName: "list.bullet.rectangle.portrait.fill"), tag: 3)
    
    let fifthVC = ProfileController()
    fifthVC.tabBarItem = UITabBarItem(title: "프로필", image: UIImage(systemName: "person.fill"), tag: 4)
    
    self.setViewControllers([firstVC, secondVC, thirdVC, fourthVC, fifthVC], animated: true)
  }
}
