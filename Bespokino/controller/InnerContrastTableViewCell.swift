//
//  InnerContrastTableViewCell.swift
//  Bespokino
//
//  Created by Bespokino on 4/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class InnerContrastTableViewCell: UITableViewCell {

    @IBOutlet weak var marker: UIImageView!
    @IBOutlet weak var innerContrastImage: UIImageView!
    @IBOutlet weak var innerContrastLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
