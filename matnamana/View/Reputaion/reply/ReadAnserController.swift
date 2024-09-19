//
//  ReadAnserController.swift
//  matnamana
//
//  Created by pc on 9/14/24.
//

import UIKit

final class ReadAnserController: BaseViewController {
  
  private var name: String
  private var requester: String
  private var target: String
  
  private var readAnswerView = ReadAnswerView(frame: .zero)
  
  init(name: String, requester: String, target: String) {
    self.name = name
    self.requester = requester
    self.target = target
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func bind() {
    super.bind()
  }
  
  override func setupView() {
    super.setupView()
    readAnswerView = ReadAnswerView(frame: UIScreen.main.bounds)
    self.view = readAnswerView
    
    readAnswerView.reName(name: name)
  }
  
}
