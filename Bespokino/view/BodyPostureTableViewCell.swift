//
//  BodyPostureTableViewCell.swift
//  Bespokino
//
//  Created by Bespokino on 11/23/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class BodyPostureTableViewCell: UITableViewCell
{
 
    @IBOutlet weak var bodyPostureImage: UIImageView!
    
    @IBOutlet weak var bodyLabel: UILabel!
    
    @IBOutlet weak var bodyView: UIView!
    
    @IBOutlet weak var marker: UIImageView!
    //
//    let simpleDataSource: [[UIImage]] = [
//
//        [UIImage(named: "posture_erect")!,UIImage(named: "posture_leaning")!,UIImage(named: "posture_normal")!],
//
//         [UIImage(named: "shoulders_steep")!,UIImage(named: "shoulders_normal")!,UIImage(named: "shoulders_flat")!],
//
//            [UIImage(named: "chest_thin")!,UIImage(named: "chest_fit")!,UIImage(named: "chest_normal")!,UIImage(named: "chest_muscular")!,UIImage(named: "chest_large")!],
//
//                [UIImage(named: "abdomen_thin")!,UIImage(named: "abdomen_normal")!,UIImage(named: "abdomen_medium")!,UIImage(named: "abdomen_large")!],
//
//                    [UIImage(named: "pelvis_thin")!,UIImage(named: "pelvis_normal")!,UIImage(named: "pelvis_curved")!,UIImage(named: "pelvis_large")!]
//
//             ]
//    var picture:[UIImage] = [
//        UIImage(named: "home")!,
//        UIImage(named: "info")!,
//        UIImage(named: "ordering")!,
//        UIImage(named: "measure")!
//    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  

}
