//
//  PayTwentyViewController.swift
//  Bespokino
//
//  Created by Bespokino on 29/11/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class PayTwentyViewController: UIViewController {

    @IBOutlet weak var creditCardButton: UIButton!
    
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var cellNumberText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var stateText: UITextField!
    @IBOutlet weak var zipText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        creditCardButton.layer.cornerRadius = 5
        creditCardButton.layer.shadowColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        creditCardButton.layer.shadowRadius = 5
        
        creditCardButton.titleLabel?.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        
        
    }


}
