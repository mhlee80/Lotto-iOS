//
//  LottoScreenView+Cell.swift
//  Lotto
//
//  Created by mhlee on 2020/10/15.
//

import UIKit
import SnapKit
import MaterialComponents

extension LottoScreenView {
}

extension LottoScreenView {
  class Cell: UITableViewCell {
    enum Constant {
      static let colorScheme: MDCSemanticColorScheme = AppTheme.colorScheme
      static let containerInsets: UIEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
      static let containerBorderColor: UIColor = colorScheme.onBackgroundColor
      static let stackInsets: UIEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
      static let numberBackgroundColor: UIColor = colorScheme.primaryColor
      static let numberTextColor: UIColor = colorScheme.onPrimaryColor
    }
    
    typealias C = Constant
    
    static var reuseIdentifier: String { return self.classForCoder().description() }
        
    private lazy var containerView: UIView = {
      let v = UIView()
      v.layer.borderWidth = 1
      v.layer.borderColor = C.containerBorderColor.cgColor
      v.layer.cornerRadius = 25
      return v
    }()
    
    private lazy var stackView: UIStackView = {
      let v = UIStackView()
      v.axis = .horizontal
      v.distribution = .fillEqually
      v.spacing = 10
      return v
    }()
    
    private lazy var numberLabels: [UILabel] = {
      var vs = [UILabel]()
      for i in 0..<6 {
        let v = SizedLabel()
        v.size = .init(width: 35, height: 35)
        v.clipsToBounds = true
        v.layer.cornerRadius = 17.5
        v.backgroundColor = C.numberBackgroundColor
        v.textColor = C.numberTextColor
        v.textAlignment = .center
        vs.append(v)
      }
      return vs
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      selectionStyle = .none
      backgroundColor = .clear
            
      contentView.addSubview(containerView)
      containerView.addSubview(stackView)
      
      contentView.addSubview(stackView)
      for label in numberLabels {
        stackView.addArrangedSubview(label)
      }

      containerView.snp.makeConstraints { make in
        make.margins.equalTo(C.containerInsets)
      }
      
      stackView.snp.makeConstraints { make in
        make.margins.equalTo(C.stackInsets)
      }
      
//      stackView.snp.makeConstraints { make in
//        make.top.equalToSuperview().offset(10)
//        make.bottom.equalToSuperview().offset(-10)
//        make.centerX.centerY.equalToSuperview()
//      }
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
