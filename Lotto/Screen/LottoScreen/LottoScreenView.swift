//
//  LottoScreenView.swift
//  Lotto
//
//  Created by mhlee on 2020/10/15.
//

import UIKit
import Foundation

class LottoScreenView: UIViewController, LottoScreenViewProtocol {
  enum Constant {
  }
  
  typealias C = Constant
  
  var presenter: LottoScreenPresenterProtocol
  
  lazy var collectionView: UICollectionView = {
    let layout = ColumnFlowLayout(cellsPerRow: 6,
                                  minimumInteritemSpacing: 10,
                                  sectionInset: UIEdgeInsets(top: 20, left: 50, bottom: 0, right: 50))
    
    let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
    v.backgroundColor = .white
    v.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
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
  
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    tryButton.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(collectionView)
    view.addSubview(tryButton)
    
    NSLayoutConstraint.activate([
      collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
      collectionView.heightAnchor.constraint(equalToConstant: 400),
    ])
    
    NSLayoutConstraint.activate([
      tryButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    
    collectionView.dataSource = self
    
    presenter.onNumbersListReloaded = { [weak self] in
      self?.handleNumbersListReloaded()
    }
    
    tryButton.addTarget(self, action: #selector(handleTryPressed(_:)), for: .touchUpInside)
    
    DispatchQueue.main.async { [unowned self] in
      self.presenter.viewDidLoad()
    }
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .default
  }
  
  @objc func handleTryPressed(_ sender: UIButton) {
    presenter.viewDidPressTry()
  }
  
  func handleNumbersListReloaded() {
    collectionView.reloadData()
  }
}

extension LottoScreenView: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return presenter.numbersList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return presenter.numbersList[section].count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
    
    cell.numberLabel.text = "\(presenter.numbersList[indexPath.section][indexPath.item])"
    return cell
  }
  
  
}
