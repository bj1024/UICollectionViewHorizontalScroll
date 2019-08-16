//
// Copyright (c) 2019, mycompany All rights reserved.
//

import UIKit

class UICollectionViewHorizontalFlowLayout: UICollectionViewFlowLayout {
  override func prepare() {
    super.prepare()

    guard let collectionView = collectionView else { return }

    print("collectionView.layoutMargins = \(collectionView.layoutMargins)")
    print("availableBounds = \(collectionView.bounds)")

    itemSize = CGSize(width: collectionView.bounds.width * 0.8, // 80% width
                      height: collectionView.bounds.height)

    minimumLineSpacing = 10 // space between items
    minimumInteritemSpacing = (collectionView.bounds.width - itemSize.width) / 2.0 // 1st or last item margin

    sectionInset = UIEdgeInsets(top: 0.0,
                                left: minimumInteritemSpacing,
                                bottom: 0.0,
                                right: minimumInteritemSpacing)
    sectionInsetReference = .fromContentInset
    scrollDirection = .horizontal

    print("estimatedItemSize = \(estimatedItemSize)")
    print("scrollDirection = \(scrollDirection)")
    print("headerReferenceSize = \(headerReferenceSize)")
    print("footerReferenceSize = \(footerReferenceSize)")
    print("sectionInset = \(sectionInset)")
  }

  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    guard let collectionView = collectionView else {
      return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
    }
    // proposedContentOffset is scrollOffset suggestion calcurated by base class.
    print("targetContentOffset \(collectionView.contentOffset) -> \(proposedContentOffset) velocity=\(velocity)")

    // add contentInset
    var searchPosX = proposedContentOffset.x + collectionView.contentInset.left
    // If velocity is present, shift the search position to page up.
    if abs(velocity.x) > 0 {
      if velocity.x > 0 {
        searchPosX += itemSize.width / 2 // right page
      }
      else {
        searchPosX -= itemSize.width / 2 // left page
      }
    }

    // Search items rect in current scrolling offset rect
    let searchRect = CGRect(x: proposedContentOffset.x,
                            y: 0,
                            width: collectionView.bounds.size.width,
                            height: collectionView.bounds.size.height)

    guard let itemsInBounds = super.layoutAttributesForElements(in: searchRect) else {
      return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
    }

    // search nearest page layout
    var offsetX: CGFloat
    let nearestItem = itemsInBounds.min { a, b in fabsf(Float(a.frame.origin.x - searchPosX)) < fabsf(Float(b.frame.origin.x - searchPosX)) }
    if let nearestItem = nearestItem {
      print("nearestItem=\(nearestItem.indexPath) x=\(nearestItem.frame.origin.x))")
      offsetX = nearestItem.frame.origin.x - (collectionView.frame.width - nearestItem.frame.width) / 2.0
    }
    else {
      print("nearestItem=nil")
      offsetX = searchPosX
    }

    let pt = CGPoint(x: offsetX, y: proposedContentOffset.y)
    print("forProposedContentOffset contentOffset=\(collectionView.contentOffset) proposed=\(proposedContentOffset) velocity=\(velocity) ret=\(pt)")
    return pt
  }

  @objc
  func injected() {
    print("I've been injected: \(self)")
    //    autoScroll()
  }
}
