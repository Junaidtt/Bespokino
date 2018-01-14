//
//  InvoiceTableViewCell.swift
//  Bespokino
//
//  Created by Bespokino on 30/11/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class InvoiceTableViewCell: UITableViewCell {

    
    @IBOutlet weak var shirtPrice: UILabel!
    @IBOutlet weak var fabricUpgradePrice: UILabel!
    
    @IBOutlet weak var stylingPrice: UILabel!
    @IBOutlet weak var shirtCount: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
