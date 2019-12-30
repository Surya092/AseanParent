//
//  UIImageView + Extension.swift
//  Test
//
//  Created by Suryanarayan Sahu on 30/12/19.
//  Copyright © 2019 Suryanarayan Sahu. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    
    /// Convince method to load image from URL into an UIImageView
    ///
    /// - Parameters:
    ///   - url: Url string for the image
    ///   - loadingIndicatoreType: Custom loading indicator type
    ///   - placeholder: Placeholder image
    ///   - placeholderImage: Placeholder image if any
    ///   - completionHandler: Completion handler
    func loadImage(fromUrl url: String, placeholder: UIImage? = nil, completionHandler: (() -> Void)? = nil)  {
        
        if let imageUrl = URL(string: url) {
            self.kf.setImage(with: imageUrl, placeholder: placeholder, options:  [.transition(ImageTransition.fade(0.6)), .forceTransition], progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
                if error != nil {
                    //load error image
                    self.image = placeholder
                    self.contentMode = .center
                } else {
                    self.backgroundColor = UIColor.clear
                }
                if let handler = completionHandler {
                    handler()
                }
            })
        } else {
            //load error image
            self.image = placeholder
            self.contentMode = .center
        }
    }
    
    // MARK: - loadImageWithoutPlaceholder
    /// Load image keeping current image showing untill new image completes it's loading;
    /// - Parameter url: URL string for the image
    func loadImageWithoutPlaceholder(fromUrl url: String) {
        if let imageUrl = URL(string: url) {
            self.kf.setImage(with: imageUrl, placeholder: nil, options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
        }
    }
    
    /// Cancel Kingfisher image loding
    func cancelLoad() {
        self.kf.cancelDownloadTask()
    }
}
