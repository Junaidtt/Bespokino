//
//  CollarCollectionViewCell.swift
//  Bespokino
//
//  Created by Bespokino on 11/8/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class CollarCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collarImage: UIImageView!
    @IBOutlet weak var collarLabel: UILabel!
    @IBOutlet weak var marker: UIImageView!
    func toggleSelected ()
    {
        //If image is selected.
        if (isSelected)
        {
            //Show check mark image.
            self.marker.isHidden = false
        }
            
        else
        {
            //Hide check mark image.
            self.marker.isHidden = true
        }
    }
}
