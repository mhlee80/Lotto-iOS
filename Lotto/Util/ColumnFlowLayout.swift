//
//  LottoScreenView+ColumnFlowLayout.swift
//  Lotto
//
//  Created by mhlee on 2020/10/15.
//

import UIKit

class ColumnFlowLayout: UICollectionViewFlowLayout {
  let cellsPerRow: Int
  let itemHeight: CGFloat
  
  init(cellsPerRow: Int,
       minimumInteritemSpacing: CGFloat = 0,
       minimumLineSpacing: CGFloat = 0,
       sectionInset: UIEdgeInsets = .zero,
       itemHeight: CGFloat = 36) {
    
    self.cellsPerRow = cellsPerRow
    self.itemHeight = itemHeight
    super.init()
    
    self.minimumInteritemSpacing = minimumInteritemSpacing
    self.minimumLineSpacing = minimumLineSpacing
    self.sectionInset = sectionInset
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepare() {
    super.prepare()
    
    guard let collectionView = collectionView else { return }
    
    var marginsAndInsets: CGFloat = sectionInset.left + sectionInset.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
    if #available(iOS 11.0, *) {
      marginsAndInsets += collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right
    }
    
    let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
    itemSize = CGSize(width: itemWidth, height: itemHeight)
  }
  
  override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
    let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
    context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
    return context
  }
}
