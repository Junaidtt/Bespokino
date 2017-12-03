//
//  CartTableViewCell.swift
//  Bespokino
//
//  Created by Bespokino on 3/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var shirtNameCount: UILabel!
    @IBOutlet weak var shirtPrice: UILabel!
    @IBOutlet weak var cartImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
