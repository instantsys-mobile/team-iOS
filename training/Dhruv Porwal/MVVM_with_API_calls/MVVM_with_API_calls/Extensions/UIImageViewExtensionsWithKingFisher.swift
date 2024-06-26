//
//  UIImageViewExtensionsWithKingFisher.swift
//  MVVM_with_API_calls
//
//  Created by DhruvPorwal on 16/06/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImageView(with urlRawString: String) {
        guard let url = URL.init(string: urlRawString) else {
            return
        }
        
        let resource = ImageResource(downloadURL: url, cacheKey: urlRawString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}
