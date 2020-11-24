//
//  LandingScreenView.swift
//  MagicWord
//
//  Created by mhlee on 2020/09/10.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class LandingScreenView: UIViewController, LandingScreenViewProtocol {
  enum Constant {
    static let logoImage = UIImage(named: "logo")
  }
  
  typealias C = Constant
  
  var presenter: LandingScreenPresenterProtocol
  
  private let disposeBag = DisposeBag()
  
  init(presenter: LandingScreenPresenterProtocol) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
  private lazy var topPanel: UIView = {
    let v = UIView()
    return v
  }()
  
  private lazy var bottomPanel: UIView = {
    let v = UIView()
    return v
  }()
    
  private lazy var logoImageView: UIImageView = {
    let v = UIImageView()
    v.image = C.logoImage
    return v
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.backgroundColor = .white
  
    view.addSubview(topPanel)
    topPanel.addSubview(logoImageView)
    
    view.addSubview(bottomPanel)
    
    topPanel.snp.makeConstraints { make in
      make.top.left.right.equalToSuperview()
      make.bottom.equalTo(view.snp.centerY)
    }
    
    logoImageView.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
        
    bottomPanel.snp.makeConstraints { make in
      make.top.equalTo(view.snp.centerY)
      make.bottom.left.right.equalToSuperview()
    }
    
    presenter.alertOkHandler = { [unowned self] title, message, completion in
      self.showAlert(title: title, message: message, kind: .ok(okTitle: nil, completion: completion))
    }
    
    DispatchQueue.main.async { [weak self] in
      self?.presenter.viewDidLoad()
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    DispatchQueue.main.async { [weak self] in
      self?.presenter.viewWillAppear()
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    DispatchQueue.main.async { [weak self] in
      self?.presenter.viewDidAppear()
    }
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .default
  }
}
