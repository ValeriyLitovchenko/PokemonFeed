//
//  UIImageView+SetImage.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import UIKit
import Kingfisher

extension UIImageView {
  
  /// Loads and sets image resource with provided url or sets a placeholder if resource unvailable.
  /// - Parameters:
  ///   - urlString: image resource url string
  ///   - noImagePlaceholder: a substitute of image when image resource for `urlString` is not available
  func setImage(
    with urlString: String?,
    noImagePlaceholder: UIImage? = nil
  ) {
    kf.cancelDownloadTask()

    let processor = DownsamplingImageProcessor(size: bounds.size)
    var kfOptions: KingfisherOptionsInfo = [
      .processor(processor),
      .loadDiskFileSynchronously,
      .cacheOriginalImage,
      .transition(.fade(0.25))
    ]
    var resourceURL: URL?
    if let urlString = urlString,
      let url = URL(string: urlString) {
      resourceURL = url
      kfOptions.append(.lowDataMode(.network(url)))
    } else {
      image = nil
    }

    kf.indicatorType = .activity

    kf.setImage(
      with: resourceURL,
      options: kfOptions,
      completionHandler: { [weak self] result in
        switch result {
        case .success: break
        case .failure:
          self?.image = noImagePlaceholder
        }
      }
    )
  }
}
