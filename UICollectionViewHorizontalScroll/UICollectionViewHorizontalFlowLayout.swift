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
    print("forProposedContentOffset \(proposedContentOffset) \(velocity)")

    var offsetAdjustment = CGFloat.greatestFiniteMagnitude
    let horizontalOffset = proposedContentOffset.x + collectionView.contentInset.left

    let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)

    let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)

    layoutAttributesArray?.forEach { layoutAttributes in
      let itemOffset = layoutAttributes.frame.origin.x
      print("itemOffset \(layoutAttributes.frame)")

      if fabsf(Float(itemOffset - horizontalOffset)) < fabsf(Float(offsetAdjustment)) {
        offsetAdjustment = itemOffset - horizontalOffset - (collectionView.frame.width - layoutAttributes.frame.width) / 2.0
      }
    }

    let pt = CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    print("forProposedContentOffset \(proposedContentOffset) \(velocity) ret=\(pt)")
    return pt
  }
}
