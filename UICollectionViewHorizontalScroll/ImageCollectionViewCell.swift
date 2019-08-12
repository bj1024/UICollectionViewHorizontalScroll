//
// Copyright (c) 2019, mycompany All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var labelTitle: UILabel!
  @IBOutlet weak var imageView: UIImageView!

  override func prepareForReuse() {
    super.prepareForReuse()

    initCell()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    initCell()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    initCell()
  }

  func initCell() {
    labelTitle.text = nil
    labelTitle.numberOfLines = 1
    imageView.image = nil
    imageView.backgroundColor = #colorLiteral(red: 0.8942228556, green: 0.8889072537, blue: 0.8983089328, alpha: 1)
    imageView.contentMode = .scaleAspectFill
//    imageView.contentMode = .scaleAspectFit

//    imageView.layer.borderWidth = 3
//    imageView.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
//    imageView.layer.cornerRadius = 2.0
  }
}
