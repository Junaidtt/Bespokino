//
//  BillingViewController.swift
//  Bespokino
//
//  Created by Bespokino on 1/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import BEMCheckBox

class BillingViewController: UIViewController ,BEMCheckBoxDelegate{

    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var streetAddressText: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var checkmark: BEMCheckBox!
    @IBOutlet weak var continueButton: UIButton!
    var checkmarkSelected:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "BESPOKINO"
        continueButton.layer.cornerRadius = 5
        continueButton.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        checkmark.delegate = self
        
    
    }

    func didTap(_ checkBox: BEMCheckBox) {
        
        print(checkBox.on)
        self.checkmarkSelected = checkBox.on
        
    }
    @IBAction func continueButtonDidTap(_ sender: Any) {
        
       print(checkmark.isSelected)
        
        if checkmarkSelected{
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ShippingAddressViewController") as! ShippingAddressViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
       }
        
        
    }
    

}
