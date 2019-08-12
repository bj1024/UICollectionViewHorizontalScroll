//
// Copyright (c) 2019, mycompany All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!

  let images: [UIImage] = [
//    UIImage(named: "image00")!,
//    UIImage(named: "image01")!,
//    UIImage(named: "image02")!,
    UIImage(named: "image03")!,
    UIImage(named: "image04")!,
    UIImage(named: "image05")!
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.delegate = self
    collectionView.dataSource = self
  }
}

extension ViewController: UICollectionViewDelegate {
//  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    guard let cell = self.collectionView.cellForItem(at: indexPath ) as? AlbumCollectionViewCell else { return }
//    let selectedCollection: [PHAssetCollection] = [photoCollections[indexPath.row]]
//
//    cell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
//    UIView.animate(withDuration: 0.3,
//                   delay: 0,
//                   options: .curveEaseOut,
//                   animations: {
//                    cell.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//    },
//                   completion: { _ in
//                    self.completion?(.success(selectedCollection))
//                    self.dismiss(animated: true, completion: nil)
//    })
//  }
}

// extension ViewController: UICollectionViewDelegateFlowLayout {
//  func collectionView(_ collectionView: UICollectionView,
//                      layout collectionViewLayout: UICollectionViewLayout,
//                      sizeForItemAt indexPath: IndexPath) -> CGSize {
//    guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { abort() }
////    let sectionInset = flowLayout.sectionInset
////
////    let column = CGFloat(columnNum)
////    let contentW: CGFloat = collectionView.bounds.width
////      - sectionInset.left
////      - sectionInset.right
////      - collectionView.contentInset.left
////      - collectionView.contentInset.right
////      - flowLayout.minimumInteritemSpacing * (column - 1)
////
////    let itemW: CGFloat = contentW / column
////    let itemH: CGFloat = itemW + 22 * 2 // 2 label height
////    return CGSize(width: itemW, height: itemH)
//    return CGSize(width: 100 , height: 100)
//  }
// }

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell",
                                                        for: indexPath)
      as? ImageCollectionViewCell else { abort() }

    let image = images[indexPath.row]

    cell.labelTitle.text = "\(indexPath.row + 1)"
//    let screenScale = UIScreen.main.scale
//    let imgSize = CGSize(width: cell.imageView.bounds.width * screenScale,
//                         height: cell.imageView.bounds.height * screenScale)

    cell.imageView.image = image

    return cell
  }
}
