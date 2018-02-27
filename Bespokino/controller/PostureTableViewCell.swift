//
//  PostureTableViewCell.swift
//  Bespokino
//
//  Created by Bespokino on 23/2/2561 BE.
//  Copyright © 2561 bespokinoapp. All rights reserved.
//

import UIKit

class PostureTableViewCell: UITableViewCell {

    @IBOutlet weak var postureValue: UILabel!
    @IBOutlet weak var postureItem: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
