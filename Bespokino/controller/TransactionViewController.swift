//
//  TransactionViewController.swift
//  Bespokino
//
//  Created by Bespokino on 29/11/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController {

    @IBOutlet weak var paymentButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        paymentButton.layer.cornerRadius = 5
        paymentButton.layer.shadowColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
    
    
    }

}
