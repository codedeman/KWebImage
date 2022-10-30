//
//  CinemaCell.swift
//  ListMovieExample
//
//  Created by Pham Kien on 04.08.22.
//

import UIKit
//import SDWebImage
protocol CinemaCellDelegate:AnyObject {
    func loadImageCompleted(index:Int)
}
class CinemaCell: UITableViewCell {
    
    static let nib = UINib.init(nibName:"\(CinemaCell.self)" , bundle: nil)
    static let identifier:String = "\(CinemaCell.self)"
    @IBOutlet weak var ivFilm: UIImageView!
    @IBOutlet weak var btnBooking: UIButton!
    @IBOutlet weak var vMain: UIView!
    @IBOutlet weak var vBoard: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var cImageHeight: NSLayoutConstraint!
    
    var indexRow:Int!
    weak var delegate:CinemaCellDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.vMain.backgroundColor = .white
        self.vBoard.layer.cornerRadius = 10
        self.vBoard.clipsToBounds = true
        self.vMain.layer.cornerRadius = 10
        self.vMain.clipsToBounds = true
        self.vMain.layer.borderColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1).cgColor
        self.vMain.layer.borderWidth = 1
        self.lblTitle.textColor = .black
        self.lblSubtitle.textColor = .black
        self.ivFilm.layer.cornerRadius = 10
        self.ivFilm.clipsToBounds = true
        self.btnBooking.layer.cornerRadius = 20
        self.btnBooking.clipsToBounds = true
        // Initialization code
    }
    
    func bindingData(data:FilmModel) {
        self.lblTitle.text = data.name
        self.lblSubtitle.text = data.price
        guard let url = URL(string: data.filmUrl ?? "" ) else { return  }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [weak self] data, _, _ in
            guard let weakSelf = self, let data = data  else {return}
            let dispatchWorkItem = DispatchWorkItem{
                print("work item start")
                sleep(1)
                print("work item end")
            }

            let dg = DispatchGroup()
            //submiy work items to the group
            let dispatchQueue = DispatchQueue(label: "custom dq")
            dispatchQueue.async(group: dg) {
                print("block start")
                sleep(2)
                print("block end")
            }
//            DispatchQueue.global().async(group: dg, execute: dispatchWorkItem) {
//
//            }
            DispatchQueue.main.async(execute: dispatchWorkItem)
            
//            dg.wait(timeout: .now()+3)
            
            //print message when all blocks in the group finish
//            dg.notify(queue: DispatchQueue.main) {
////                print("dispatch group over")
//                self?.ivFilm.image = UIImage(data: data)
//            }
        }
        task.resume()
       }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func  getAspectRatioAccording(_ imageSize:CGSize) ->Float {
          let  aspectRatio = imageSize.height / imageSize.width
          let targetWith = UIScreen.main.bounds.size.width-20*2 // kích thước 2 bên
          let targetHeight = (targetWith * aspectRatio)
          return Float(targetHeight)
      }
    
}
