//
//  SizedLabel.swift
//  Lotto
//
//  Created by mhlee on 2020/10/18.
//

import UIKit

class SizedLabel: UILabel {
  var size: CGSize = .zero {
    didSet {
      invalidateIntrinsicContentSize()
    }
  }
  
  override var intrinsicContentSize: CGSize {
    return size
  }
}
