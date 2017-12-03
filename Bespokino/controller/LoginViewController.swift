//
//  LoginViewController.swift
//  Bespokino
//
//  Created by Bespokino on 11/11/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordtextField: UITextField!
    
    
    let async:AsyncTask = AsyncTask()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationItem.title = "BESPOKINO"
        
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
        passwordtextField.layer.borderWidth = 0.5
        passwordtextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    }

    @IBAction func signInButtontapped(_ sender: Any) {
        let sync = AsyncTask(view:self)

        let email = emailTextField.text
        let password = passwordtextField.text
        if ((email?.isEmpty)! || (password?.isEmpty)!){
            sync.displayAlertMessage(messageToDisplay: "Empty text field")
        }else{
            
            let isValiedEmail = async.isValidEmailAddress(emailAddressString: email!)
            if isValiedEmail{
               
                
                let loginUser = User(email: email!, pass: password!)
                sync.loginTask(user: loginUser)
                
                
            }else{
                
                sync.displayAlertMessage(messageToDisplay: "Invalied email")
            }
       
            
            
        }
  
        
        
    }
    
    
    
    @IBAction func registrationButtonTapped(_ sender: Any) {
        
        
        performSegue(withIdentifier: "reg", sender: self)
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //This will hide the keyboard
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
  
}
