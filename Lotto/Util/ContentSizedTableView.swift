//
//  LottoScreenView+ContentSizedTableView.swift
//  Lotto
//
//  Created by mhlee on 2020/10/18.
//

import UIKit

final class ContentSizedTableView: UITableView {
  override var contentSize:CGSize {
    didSet {
      invalidateIntrinsicContentSize()
    }
  }
  
  override var intrinsicContentSize: CGSize {
    layoutIfNeeded()
    return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
  }
}
