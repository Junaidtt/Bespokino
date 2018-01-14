//
//  LoginViewController.swift
//  Bespokino
//
//  Created by Bespokino on 11/11/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
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
    
        if self.revealViewController() != nil {
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        btnMenuButton.target = revealViewController()
        btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
    }

    @IBAction func signInButtontapped(_ sender: Any) {
        let sync = AsyncTask(view:self)
        let checkInternet  = CheckInternetConnection()
        
    
    
        
        let email = emailTextField.text
        let password = passwordtextField.text
        if ((email?.isEmpty)! || (password?.isEmpty)!){
            sync.displayAlertMessage(messageToDisplay: "Empty text field")
        }else{
            
            let isValiedEmail = async.isValidEmailAddress(emailAddressString: email!)
            if isValiedEmail{
               
                if  checkInternet.isConnectedToNetwork(){
                    let loginUser = User(email: email!, pass: password!)
                    sync.loginTask(view:self.view, user: loginUser)
                }else{
                    displayAlert()
                }
            
            }else{
                
                sync.displayAlertMessage(messageToDisplay: "Invalied email")
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
    
    @IBAction func registrationButtonTapped(_ sender: Any) {
        
        let regIn = UserDefaults.standard.bool(forKey: "isRegIn")
        if regIn{

            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "BodyPosturesViewController") as! BodyPosturesViewController
       
            self.navigationController?.pushViewController(newViewController, animated: true)
            
        }else{
            performSegue(withIdentifier: "reg", sender: self)

        }

        
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
