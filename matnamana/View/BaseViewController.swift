//
//  BaseViewController.swift
//  matnamana
//
//  Created by 김윤홍 on 9/4/24.
//

import UIKit

import RxCocoa
import RxSwift

class BaseViewController: UIViewController {
  var disposeBag = DisposeBag()
  
  override func loadView() {
    super.loadView()
    setupView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigation()
    bind()
    view.backgroundColor = .systemBackground
  }
  
  func setNavigation() {
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.largeTitleDisplayMode = .always
  }
  
  func bind() {
    
  }
  
  func setupView() {
    
  }
}
