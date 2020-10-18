//
//  LottoScreenView.swift
//  Lotto
//
//  Created by mhlee on 2020/10/15.
//

import UIKit
import Foundation
import RxSwift
//import RxCocoa

class LottoScreenView: UIViewController, LottoScreenViewProtocol {
  enum Constant {
  }
  
  typealias C = Constant
  
  var presenter: LottoScreenPresenterProtocol
  
  let disposeBag = DisposeBag()
//  lazy var collectionView: UICollectionView = {
//    let layout = ColumnFlowLayout(cellsPerRow: 6,
//                                  minimumInteritemSpacing: 10,
//                                  sectionInset: UIEdgeInsets(top: 20, left: 50, bottom: 0, right: 50))
//
//    let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
//    v.backgroundColor = .white
//    v.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
//    return v
//  }()
  
  lazy var tableView: UITableView = {
    let v = ContentSizedTableView()
    v.separatorStyle = .none
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
  
//    collectionView.translatesAutoresizingMaskIntoConstraints = false
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tryButton.translatesAutoresizingMaskIntoConstraints = false
    
//    view.addSubview(collectionView)
    view.addSubview(tableView)
    view.addSubview(tryButton)
    
//    NSLayoutConstraint.activate([
//      collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//      collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//      collectionView.heightAnchor.constraint(equalToConstant: 400),
//    ])
    
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
    
//    collectionView.dataSource = self
//    tableView.dataSource = self
    
//    presenter.listenerForNumbersList = { [weak self] _ in
//      self?.handleNumbersListUpdated()
//    }
    
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
    
//  func handleNumbersListUpdated() {
////    collectionView.reloadData()
//    tableView.reloadData()
//  }
}

//extension LottoScreenView: UICollectionViewDataSource {
//  func numberOfSections(in collectionView: UICollectionView) -> Int {
//    return presenter.numbersList.count
//  }
//
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return presenter.numbersList[section].count
//  }
//
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
//
//    cell.numberLabel.text = "\(presenter.numbersList[indexPath.section][indexPath.item])"
//    return cell
//  }
//}

//extension LottoScreenView: UITableViewDataSource {
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return presenter.numbersList.count
//  }
//
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
//    cell.configureWithNumbers(presenter.numbersList[indexPath.row])
//    return cell
//  }
//}
