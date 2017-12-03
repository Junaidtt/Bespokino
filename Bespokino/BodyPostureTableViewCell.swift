//
//  BodyPostureTableViewCell.swift
//  Bespokino
//
//  Created by Bespokino on 11/23/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class BodyPostureTableViewCell: UITableViewCell {

    @IBOutlet weak var bodyPostureLabel: UILabel!
    @IBOutlet weak var bodyPostureImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
