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
        
        self.ivData.k_setImageWithUrl(url: url,placeHolder: UIImage(named: "imgPlaceHolder"),showLoading: true,resize: CGSize(width: 50, height: 50))
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.ivData.k_cancelImageLoading()
        }
        guard let url2 = URL(string: "https://iscale.iheart.com/v3/surl/aHR0cDovL2ltYWdlLmloZWFydC5jb20vaW1hZ2VzL3JvdmkvMTA4MC8wMDA1LzMyNy9NSTAwMDUzMjc3NTkuanBn?sn=eGtleWJhc2UyMDIxMTExMDrXsyIrKBG7HIAJ5quoktUSiMvZMLZMNQey0BB1dSqT0A%3D%3D&surrogate=1cOXl179JY-syhxYSCX6Q1a_Mcu6UO8d-F4oJzpZf1hcUbJr4aIgxNUIAQHp1k9NZfVmzdK5ntDaEMk1JfHht1k_Hu6xiEKA1RK2-952TOdpTPTZKKhM8B78aqq5YHWFU7IYVd41Qh6pGuK7GXK7NJrz3yPLlBmimgqRduLUdSF9-s4z-a-kB4DZgLT3uy2fw2lMaKF7zCZRu2U6wBQbPsUw") else {return}

        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            self.ivData.k_setImageWithUrl(url: url2,showLoading: true)
        }

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
