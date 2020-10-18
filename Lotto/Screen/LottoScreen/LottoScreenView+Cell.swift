//
//  LottoScreenView+Cell.swift
//  Lotto
//
//  Created by mhlee on 2020/10/15.
//

import UIKit
import SnapKit

extension LottoScreenView {
}

extension LottoScreenView {
  class Cell: UITableViewCell {
    enum Constant {
    }
    
    typealias C = Constant
    
    static var reuseIdentifier: String { return self.classForCoder().description() }
    
    private lazy var stackView: UIStackView = {
      let v = UIStackView()
      v.axis = .horizontal
      v.spacing = 10
      return v
    }()
    
    private lazy var numberLabels: [UILabel] = {
      var vs = [UILabel]()
      for i in 0..<6 {
        let v = SizedLabel()
        v.size = .init(width: 30, height: 30)
        v.textAlignment = .center
        vs.append(v)
      }
      return vs
    }()
                
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      selectionStyle = .none
      backgroundColor = .clear
      
      contentView.addSubview(stackView)
      for label in numberLabels {
        stackView.addArrangedSubview(label)
      }

      stackView.snp.makeConstraints { make in
        make.top.bottom.centerX.centerY.equalToSuperview()
      }
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    func configureWithNumbers(_ numbers: [Int]) {
      for i in 0..<numbers.count {
        let l = numberLabels[i]
        l.text = "\(numbers[i])"
      }
    }
  }
}
