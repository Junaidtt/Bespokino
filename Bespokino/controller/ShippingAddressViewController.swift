//
//  ShippingAddressViewController.swift
//  Bespokino
//
//  Created by Bespokino on 1/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class ShippingAddressViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var continueButton: UIButton!

    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var streetAddressText: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
     var activeTextField = UITextField()
    var shipping = [Invoice]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    
        self.navigationItem.title = "BESPOKINO"
    
       // self.setDataInTextField()
    }

    
    func setDataInTextField()  {
       
        if shipping.count>0 {
            self.firstNameText.text = shipping[0].firstName
            self.lastNameText.text = shipping[0].lastName
            self.streetAddressText.text = shipping[0].address
            self.cityTextField.text = shipping[0].city
            self.stateTextField.text = shipping[0].state
            self.zipTextField.text = shipping[0].zip
            self.countryTextField.text = shipping[0].country
            
        }
       
        
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        activeTextField = textField
        
        
        switch activeTextField {
        case firstNameText:
            lastNameText.becomeFirstResponder()
        case lastNameText:
            streetAddressText.becomeFirstResponder()
        case streetAddressText:
            cityTextField.becomeFirstResponder()
        case cityTextField:
            zipTextField.becomeFirstResponder()
        case zipTextField:
            countryTextField.becomeFirstResponder()
        case countryTextField:
            firstNameText.becomeFirstResponder()
            
            
        default:
            print("No textfield selected :")
        }
        return false
    }
    @IBAction func continueButtonDidTap(_ sender: Any) {

        
        _ = navigationController?.popViewController(animated: true)
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ConfirmPayViewController") as! ConfirmPayViewController
//        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    

}
