//
//  BaseViewController.swift
//  matnamana
//
//  Created by 김윤홍 on 9/4/24.
//

import UIKit

import RxCocoa
import RxSwift
import RxKeyboard

class BaseViewController: UIViewController {
  var disposeBag = DisposeBag()
  
  override func loadView() {
    
    setupView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bind()
    setNavigation()
    setupKeyboardHandling()
    overrideUserInterfaceStyle = .light
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
  
  private func setupKeyboardHandling() {
    RxKeyboard.instance.visibleHeight
      .drive(onNext: { [weak self] keyboardHeight in
        guard let self = self else { return }
        self.adjustForKeyboardHeight(keyboardHeight)
      })
      .disposed(by: disposeBag)
    
  }
  func adjustForKeyboardHeight(_ keyboardHeight: CGFloat) {
    
  }
  
  func setupDismissKeyboardGesture() {
    let tapGesture = UITapGestureRecognizer()
    self.view.addGestureRecognizer(tapGesture)
    
    tapGesture.rx.event
      .bind(onNext: { [weak self] _ in
        guard let self else { return }
        self.view.endEditing(true) // 키보드를 숨기기
      })
      .disposed(by: disposeBag)
  }
}

