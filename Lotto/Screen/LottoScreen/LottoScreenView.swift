//
//  LottoScreenView.swift
//  Lotto
//
//  Created by mhlee on 2020/10/15.
//

import UIKit
import Foundation
import RxSwift

class LottoScreenView: UIViewController, LottoScreenViewProtocol {
  enum Constant {
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
  
  lazy var tryButton: UIButton = {
    let v = UIButton(type: .system)
    v.setTitle("Try", for: .normal)
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
  
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tryButton.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(tableView)
    view.addSubview(tryButton)
        
    NSLayoutConstraint.activate([
      tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
    ])
    
    NSLayoutConstraint.activate([
      tryButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
        
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
