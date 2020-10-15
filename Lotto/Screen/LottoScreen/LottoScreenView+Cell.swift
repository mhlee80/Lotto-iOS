//
//  LottoScreenView+Cell.swift
//  Lotto
//
//  Created by mhlee on 2020/10/15.
//

import UIKit

extension LottoScreenView {
  class Cell: UICollectionViewCell {
    enum Constant {
    }
    
    typealias C = Constant
    
    static var reuseIdentifier: String { return self.classForCoder().description() }
    
    lazy var numberLabel: UILabel = {
      let v = UILabel()
      return v
    }()
        
    override init(frame: CGRect) {
      super.init(frame: frame)
      
      numberLabel.translatesAutoresizingMaskIntoConstraints = false
      
      contentView.addSubview(numberLabel)
      
      NSLayoutConstraint.activate([
        numberLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
      ])
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
  }
}
