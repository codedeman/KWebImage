//
//  ViewController.swift
//  GDCExample
//
//  Created by Kevin on 10/24/22.
//

import UIKit
import SDWebImage
import KWebImage 
class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ivData: UIImageView!
    lazy var imageDownloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.flickrTest.imageDownloadqueue"
        queue.qualityOfService = .userInteractive
        return queue
    }()
    var listFilms:[FilmModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.register(UINib(nibName: "", bundle: nil), forCellReuseIdentifier: "")
//        self.tableView.register(CinemaCell.nib, forCellReuseIdentifier: CinemaCell.identifier)
//        self.tableView.delegate = self
//        self.tableView.dataSource = self

//        MovieService.instance.getListMovie { [weak self] film in
//            guard let self = self else {return}
//            self.listFilms = film.listFilms
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
        
        guard let url = URL(string:  "https://media-api.advertisingvietnam.com/oapi/v1/media?uuid=public%2Fwp-content%2Fuploads%2F2020%2F02%2Fstarbuck-that-bai-tai-viet-nam-thumbal.jpg&resolution=1440x756&type=image" ) else { return  }
        
        self.ivData.k_setImageWithUrl(url: url,placeHolder: UIImage(named: "imgPlaceHolder"),showLoading: true,resize: CGSize(width: 100, height: 200))
        self.ivData.k_pausingImageLoading()

    }


    @IBAction func didTabCancelBtn(_ sender: Any) {
        print("cancel task inprocess")
//        ImageDownloadManager.shared.operation.cancel()
        self.ivData.sd_cancelCurrentImageLoad()
//        self.ivData.image.
        
        

    }
}

//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        self.listFilms?.count ?? 0
//
//    }
//
////
////    func numberOfSections(in tableView: UITableView) -> Int {
////        self.listFilms?.count
////    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell:CinemaCell = tableView.dequeueReusableCell(withIdentifier: CinemaCell.identifier) as? CinemaCell else {return UITableViewCell()}
//       guard let data = listFilms?[indexPath.row] else {return UITableViewCell()}
//        cell.bindingData(data: data)
//        return cell
//
//    }
//}
//
//
