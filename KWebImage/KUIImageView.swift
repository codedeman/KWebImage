//
//  KUIImage.swift
//  KWebImage
//
//  Created by Kevin on 10/30/22.
//

import UIKit
extension UIImageView {
    public func k_setImageWithUrl(url: URL,placeHolder: UIImage? = nil,showLoading: Bool = false,resize:CGSize? = nil) {
        let indicator = UIActivityIndicatorView(style: .large)
       indicator.tintColor = .blue
        indicator.color = .blue
       self.addSubview(indicator)
       indicator.translatesAutoresizingMaskIntoConstraints = false
       indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
       indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        if showLoading {
            indicator.startAnimating()
        }
        self.image = placeHolder
        ImageDownloadManager.shared.dowLoadImage(url: url) { image, url, indexPath, error in
            DispatchQueue.main.async {
                indicator.stopAnimating()
            }
            if error != nil {
                self.image = placeHolder
            } else {
                DispatchQueue.main.async {
                    if let resize = resize  {
                        self.image = image?.scalePreservingAspectRatio(targetSize: resize)
                    } else {
                        self.image = image
                    }
                }
            }
        }
    }
    
    public func k_cancelImageLoading() {
        ImageDownloadManager.shared.cancelTaskProcess()
    }
    
    public func k_pausingImageLoading() {
        ImageDownloadManager.shared.pauseTaskProcess()
    }
    
    // Technique #1
   public func resizedImage(at url: URL, for size: CGSize)  {
        guard let image = UIImage(contentsOfFile: url.path) else {
            return
        }
        let renderer = UIGraphicsImageRenderer(size: size)
        self.image =  renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}


extension UIImage {
    
    fileprivate func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage  {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / self.size.width
        let heightRatio = targetSize.height / self.size.height
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: self.size.width * scaleFactor,
            height: self.size.height * scaleFactor
        )
        
        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )
        
        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        return scaledImage
    }
    
}
