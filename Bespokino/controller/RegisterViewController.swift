//
//  RegisterViewController.swift
//  Bespokino
//
//  Created by Bespokino on 11/11/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class RegisterViewController: UIViewController,UIPickerViewDelegate,UITextFieldDelegate,GIDSignInUIDelegate {
   
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    @IBOutlet weak var firstNameTextField: UITextField!

    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    var activeTextField = UITextField()
   // var size = ["27","28","29","30","31","32","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationItem.title = "BESPOKINO"
        configureGoogleSignInButton()

       // picker.delegate = self
      //  picker.dataSource = self
        
        
       // pantWaistSize.inputView = picker
        
     //   pantWaistSize.layer.borderWidth = 0.5
      //  pantWaistSize.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        firstNameTextField.layer.borderWidth = 0.5
        firstNameTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
       
        
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailTextField.keyboardType = UIKeyboardType.emailAddress
        
        
        
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        

        
//        let toolbarDone = UIToolbar.init()
//        toolbarDone.sizeToFit()
//        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done,
//                                              target: self, action: #selector(doneButton_Clicked))
//
//
//        toolbarDone.items = [barBtnDone] // You can even add cancel button too
//        cellNumberTextField.inputAccessoryView = toolbarDone
//        pantWaistSize.inputAccessoryView = toolbarDone
        
    }

    @IBAction func registerButtonTapped(_ sender: Any) {
        
        let async = AsyncTask(view:self)

        let firstname = firstNameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        
        if (firstname?.isEmpty)! ||  (email?.isEmpty)! || (password?.isEmpty)!{
            
            async.displayAlertMessage(messageToDisplay: "Empty fields not allowed")
            
        }else{
            if (!async.isValidEmailAddress(emailAddressString: email!)){
                
                async.displayAlertMessage(messageToDisplay: "Invalied email")
            }else{
                
                let checkInternet = CheckInternetConnection()
                
                
                if checkInternet.isConnectedToNetwork(){
                
                    let regUser = User(firstname: firstname!,email: email!,pass: password!)

                    let regTask = AsyncTask(view:self)

                    regTask.regUserTask(view: self, user: regUser)
                    
                }else{
 
                    displayAlert()
              
                }
                
 }

        }
        
        
        
    }
    func displayAlert()  {
        let topWindow = UIWindow(frame: UIScreen.main.bounds)
        topWindow.rootViewController = UIViewController()
        topWindow.windowLevel = UIWindowLevelAlert + 1
        let alert = UIAlertController(title: "No Internet", message: "please check your internet connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "confirm"), style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
            // continue your work
            // important to hide the window after work completed.
            // this also keeps a reference to the window until the action is invoked.
            topWindow.isHidden = true
        }))
        topWindow.makeKeyAndVisible()
        topWindow.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
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
            emailTextField.becomeFirstResponder()
        
       
            
        case emailTextField:
            passwordTextField.becomeFirstResponder()
     
            
//        case passwordTextField:
//            pantWaistSize.becomeFirstResponder()
        default:
            print("No text field selected")
        }
     
        // Do not add a line break
        return false
    }
    
    @objc func doneButton_Clicked() {
       //  cellNumberTextField.resignFirstResponder()
        passwordTextField.becomeFirstResponder()
    }
 
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        _ = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        
        if textField == firstNameTextField{
            
            let allowedCharacters = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn:string)
            return allowedCharacters.isSuperset(of: characterSet)
            
        }
       else{
            
            return true
        }
    }
    

    
    fileprivate func configureGoogleSignInButton() {
//        let googleSignInButton = GIDSignInButton()
//        googleSignInButton.frame = CGRect(x: 120, y: 200, width: view.frame.width - 240, height: 50)
//        view.addSubview(googleSignInButton)
        
        GIDSignIn.sharedInstance().uiDelegate = self
    }
}
