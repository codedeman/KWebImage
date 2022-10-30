//
//  ImageDownloadManager.swift
//  GDCExample
//
//  Created by Kevin on 10/30/22.
//

import Foundation
import UIKit
final class ImageDownloadManager {
    private var completionHandler: ImageDownloadHandler?
    var operation: PGOperation!
    let imageCache = NSCache<NSString, UIImage>()
    static var shared = ImageDownloadManager()
    private init() {}
    
    lazy var imageDownloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.flickrTest.imageDownloadqueue"
        queue.qualityOfService = .userInteractive
        return queue
    }()
    
    func dowLoadImage(url:URL, hander:@escaping ImageDownloadHandler) {
        self.completionHandler = hander
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            print("Return cached image for \(url)")
            self.completionHandler?(cachedImage, url, nil, nil)
        } else {
            operation = PGOperation(url: url, indexPath: nil)
            operation.downloadHandler = { (image, url, indexPath, error) in
                if let newImage = image {
                    self.imageCache.setObject(newImage, forKey: url.absoluteString as NSString)
                }
                self.operation.queuePriority = .high
                self.completionHandler?(image, url, indexPath, error)
            }
            imageDownloadQueue.addOperation(operation)
        }
    }
    func cancelTaskProcess() {
        imageDownloadQueue.cancelAllOperations()
    }
}

extension UIImageView {
    func k_setImageWithUrl(url: URL,placeHolder: UIImage? = nil) {
        self.image = placeHolder
        ImageDownloadManager.shared.dowLoadImage(url: url) { image, url, indexPath, error in
            if error != nil {
                self.image = placeHolder
            } else {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
    
    func cancelImageLoading() {
        ImageDownloadManager.shared.cancelTaskProcess()
    }
}
