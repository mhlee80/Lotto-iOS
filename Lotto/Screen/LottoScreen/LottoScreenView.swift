//
//  LottoScreenView.swift
//  Lotto
//
//  Created by mhlee on 2020/10/15.
//

import UIKit
import Foundation
import RxSwift
import SnapKit
import MaterialComponents

class LottoScreenView: UIViewController, LottoScreenViewProtocol {
  enum Constant {
    static let colorScheme: MDCSemanticColorScheme = AppTheme.colorScheme
  }
  
  typealias C = Constant
  
  var presenter: LottoScreenPresenterProtocol
  
  let disposeBag = DisposeBag()
  
  lazy var tableView: UITableView = {
    let v = ContentSizedTableView()
    v.separatorStyle = .none
    v.isScrollEnabled = false
    v.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
    return v
  }()
  
  lazy var buttonScheme: MDCContainerScheming = {
    let s = MDCContainerScheme()
    s.colorScheme = C.colorScheme
    return s
  }()
  
  lazy var tryButton: UIButton = {
    let v = MDCButton()
    v.applyContainedTheme(withScheme: buttonScheme)
    v.layer.cornerRadius = 0
    v.setTitle("번호 생성", for: .normal)
    return v
  }()
 
  init(presenter: LottoScreenPresenterProtocol) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.backgroundColor = .white
      
    view.addSubview(tableView)
    view.addSubview(tryButton)
            
    tableView.snp.makeConstraints { make in
      make.centerX.centerY.leading.trailing.equalToSuperview()
    }
    
    tryButton.snp.makeConstraints { make in
      make.left.right.bottom.equalToSuperview()
      make.height.equalTo(68)
    }
            
    presenter.numbersList.asObservable()
      .bind(to: tableView
        .rx
        .items(cellIdentifier: Cell.reuseIdentifier,
               cellType: Cell.self)) { row, numbers, cell in
                cell.configureWithNumbers(numbers) }
      .disposed(by: disposeBag)
    
    tryButton.rx.tap
      .bind { [unowned self] in
        self.presenter.viewDidPressTry() }
      .disposed(by: disposeBag)
        
    DispatchQueue.main.async { [unowned self] in
      self.presenter.viewDidLoad()
    }
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .default
  }
}
