//
//  ImageLoader.swift
//  GDCExample
//
//  Created by Kevin on 10/30/22.
//

import Foundation
import UIKit

typealias ImageDownloadHandler = (_ image: UIImage?, _ url: URL, _ indexPath: IndexPath?, _ error: Error?) -> Void

//final class NetworkOperation: AsynOp
final class KOperation: Operation {
    
    var downloadHandler: ImageDownloadHandler?
    var imageUrl: URL!
    private var indexPath: IndexPath?
//    var state = Sate.read
    override var isAsynchronous: Bool {
        get {
            return  true
        }
    }
    private var _executing = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    override var isExecuting: Bool {
        return _executing
    }
    
    private var _finished = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
    
    override var isFinished: Bool {
        return _finished
    }
    
    func executing(_ executing: Bool) {
        _executing = executing
    }
    
    func finish(_ finished: Bool) {
        _finished = finished
    }
    
    required init (url: URL, indexPath: IndexPath?) {
        self.imageUrl = url
        self.indexPath = indexPath
    }
    
    override func main() {
        guard isCancelled == false else {
            finish(true)
            return
        }
        self.executing(true)
        //Asynchronous logic (eg: n/w calls) with callback
        self.downloadImageFromUrl()
    }
    
    func downloadImageFromUrl() {
        let newSession = URLSession.shared
       let downloadTask = newSession.downloadTask(with: self.imageUrl) { (location, response, error) in
           if let locationUrl = location, let data = try? Data(contentsOf: locationUrl){
               let image = UIImage(data: data)
               self.downloadHandler?(image,self.imageUrl, self.indexPath,error)
           } else if let error = error {
               self.downloadHandler?(nil,self.imageUrl, nil,error)
           }
          self.finish(true)
          self.executing(false)

        } // todo 
        downloadTask.resume()
    }
}
