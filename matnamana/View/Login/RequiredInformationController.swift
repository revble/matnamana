//
//  LoginController.swift
//  matnamana
//
//  Created by 김윤홍 on 8/23/24.
//

import UIKit
import RxSwift
import RxCocoa

class RequiredInformationController: UIViewController {
  private var requiredInformationView: RequiredInformationView?
  private let disposeBag = DisposeBag()
  
  override func loadView() {
    requiredInformationView = RequiredInformationView(frame: UIScreen.main.bounds)
    self.view = requiredInformationView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
}
