//
//  RegisterViewController.swift
//  Bespokino
//
//  Created by Bespokino on 11/11/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
   

    @IBOutlet weak var pantWaistSize: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cellNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var activeTextField = UITextField()
    var size = ["27","28","29","30","31","32","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49"]
    
    let picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationItem.title = "BESPOKINO"

        picker.delegate = self
        picker.dataSource = self
        
        
        pantWaistSize.inputView = picker
        
        pantWaistSize.layer.borderWidth = 0.5
        pantWaistSize.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        firstNameTextField.layer.borderWidth = 0.5
        firstNameTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        lastNameTextField.layer.borderWidth = 0.5
        lastNameTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailTextField.keyboardType = UIKeyboardType.emailAddress
        
        cellNumberTextField.layer.borderWidth = 0.5
        cellNumberTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cellNumberTextField.keyboardType = UIKeyboardType.numberPad
        
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        

        
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done,
                                              target: self, action: #selector(doneButton_Clicked))
        
       
        toolbarDone.items = [barBtnDone] // You can even add cancel button too
        cellNumberTextField.inputAccessoryView = toolbarDone
        pantWaistSize.inputAccessoryView = toolbarDone
        
    }

    @IBAction func registerButtonTapped(_ sender: Any) {
        
        let async = AsyncTask(view:self)

        let firstname = firstNameTextField.text
        let lastname = lastNameTextField.text
        let email = emailTextField.text
        let cellnumber = cellNumberTextField.text
        let password = passwordTextField.text
        let pantwaistsize = pantWaistSize.text
        
        if (firstname?.isEmpty)! || (lastname?.isEmpty)! || (email?.isEmpty)! || (cellnumber?.isEmpty)! || (password?.isEmpty)! || (pantwaistsize?.isEmpty)!{
            
            async.displayAlertMessage(messageToDisplay: "Empty fields not allowed")
            
        }else{
            if (!async.isValidEmailAddress(emailAddressString: email!)){
                
                async.displayAlertMessage(messageToDisplay: "Invalied email")
            }else{
                
                let regUser = User(firstname: firstname!, lastname: lastname!, email: email!, phonenumber: cellnumber!, pass: password!,size:pantwaistsize!)
                
                let regTask = AsyncTask(view:self)
                
                regTask.regUserTask(view: self, user: regUser)
                
            }

        }
        
        
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return size.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return size[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        pantWaistSize.text = size[row]
        self.view.endEditing(false)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //This will hide the keyboard
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        
        activeTextField = textField
        
        switch activeTextField {
        case firstNameTextField:
            lastNameTextField.becomeFirstResponder()
        
        case lastNameTextField:
            emailTextField.becomeFirstResponder()
            
        case emailTextField:
            cellNumberTextField.becomeFirstResponder()
        case cellNumberTextField:
            passwordTextField.becomeFirstResponder()
            
        case passwordTextField:
            pantWaistSize.becomeFirstResponder()
        default:
            print("No text field selected")
        }
     /*   if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        } */
        // Do not add a line break
        return false
    }
    
    @objc func doneButton_Clicked() {
         cellNumberTextField.resignFirstResponder()
        passwordTextField.becomeFirstResponder()
    }
 
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let str = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        
        if textField == firstNameTextField{
            
            let allowedCharacters = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn:string)
            return allowedCharacters.isSuperset(of: characterSet)
            
        }else if textField == lastNameTextField{
            
            let allowedCharacters = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn:string)
            return allowedCharacters.isSuperset(of: characterSet)
            
        }
       
       else if textField == cellNumberTextField{
          
            return checkUSPhoneNumberFormat(string: string, str: str)
            
        }else{
            
            return true
        }
    }
    
    func checkUSPhoneNumberFormat(string: String?, str: String?) -> Bool{
        
        if string == ""{ //BackSpace
            
            return true
            
        }else if str!.count < 3{
            
            if str!.count == 1{
                
                cellNumberTextField.text = "("
            }
            
        }else if str!.count == 5{
            
            cellNumberTextField.text = cellNumberTextField.text! + ") "
            
        }else if str!.count == 10{
            
            cellNumberTextField.text = cellNumberTextField.text! + "-"
            
        }else if str!.count > 14{
            
            return false
        }
        
        return true
    }
    
}
