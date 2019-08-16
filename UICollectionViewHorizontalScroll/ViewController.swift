//
// Copyright (c) 2019, mycompany All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  var scrollDiff: CGFloat = 1
  let images: [UIImage] = [
    UIImage(named: "image00")!,
    UIImage(named: "image01")!,
    UIImage(named: "image02")!,
    UIImage(named: "image03")!,
    UIImage(named: "image04")!,
    UIImage(named: "image05")!
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.decelerationRate = UIScrollView.DecelerationRate.fast

//    collectionView.layer.borderColor = UIColor.orange.cgColor
//    collectionView.layer.borderWidth = 1
    //    autoScroll()
  }

  @objc
  func injected() {
    print("I've been injected: \(self)")
//    autoScroll()
  }

  func autoScroll() {

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
      self.collectionView.contentOffset.x += self.scrollDiff
      if self.collectionView.contentOffset.x > self.collectionView.bounds.width * CGFloat(self.images.count - 1) {
        self.scrollDiff = -1
      }
      else if self.collectionView.contentOffset.x < 0 {
        self.scrollDiff = 1
      }
      self.autoScroll()
    }
  }
}

extension ViewController: UICollectionViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //    print("scrollViewDidScroll \(collectionView.position)")
  }

  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    print("willDisplay \(indexPath)")
  }
}

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
