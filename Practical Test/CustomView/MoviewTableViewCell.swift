//
//  MoviewTableViewCell.swift
//  Practical Test
//
//  Created by localadmin on 31/5/2022.
//

import UIKit
import Foundation

class MoviewTableViewCell: UITableViewCell {

    @IBOutlet weak var movieDescription: UILabel!
    
    @IBOutlet weak var BannerImage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        movieDescription.sizeToFit()
        movieDescription.layoutIfNeeded()
        movieDescription.text = "Candidate will use the following URL to parse JSON data the following URL to parse JSON data"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureTableData() {
//        if let grad_img = data?["image"].string {
//            let url = URL(string: grad_img)
//            productImage.kf.indicatorType = .activity
//            productImage.kf.setImage(with: url, placeholder: UIImage(named: "ic_profile_placeholder"))
//
//            productImage.layer.cornerRadius = 4;
//            productImage.layer.masksToBounds = true;
//        }
//        else {
//            productImage.image = UIImage(named: "demoGrad")!
//            productImage.layer.cornerRadius = 4;
//            productImage.layer.masksToBounds = true;
//        }
//
   }
    
}
