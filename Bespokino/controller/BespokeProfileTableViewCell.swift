//
//  BespokeProfileTableViewCell.swift
//  Bespokino
//
//  Created by Bespokino on 16/3/2561 BE.
//  Copyright © 2561 bespokinoapp. All rights reserved.
//

import UIKit

class BespokeProfileTableViewCell: UITableViewCell {

 
    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
