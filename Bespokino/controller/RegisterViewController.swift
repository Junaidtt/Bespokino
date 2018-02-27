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
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit
import SVProgressHUD

class RegisterViewController: UIViewController,UIPickerViewDelegate,UITextFieldDelegate,GIDSignInUIDelegate,FBSDKLoginButtonDelegate  {
   
    
    
    @IBOutlet weak var facebookSignInButton: FBSDKLoginButton!
    
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    @IBOutlet weak var firstNameTextField: UITextField!

    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    var activeTextField = UITextField()
    
    let btnSize : CGFloat = 100
   // var size = ["27","28","29","30","31","32","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationItem.title = "BESPOKINO"
        configureGoogleSignInButton()
  
        facebookSignInButton.setAttributedTitle(NSAttributedString(string: "Sign up"), for: .normal)
        facebookSignInButton.layer.cornerRadius = 3.0
        facebookSignInButton.layer.masksToBounds = true
        facebookSignInButton.layer.borderColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        facebookSignInButton.layer.borderWidth = 0.3
        facebookSignInButton.layer.shadowColor = UIColor.black.cgColor
        facebookSignInButton.layer.shadowOpacity = 1
        facebookSignInButton.layer.shadowOffset = CGSize.zero
        facebookSignInButton.layer.shadowRadius = 10
        

        firstNameTextField.layer.borderWidth = 0.5
        firstNameTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
       
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailTextField.keyboardType = UIKeyboardType.emailAddress
        
        
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.statusBarStyle = .default
        
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
           
            FBSDKLoginManager().logOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
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
    //FBSDKLoginButton delegate methods
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        SVProgressHUD.show()
        if error == nil {
            print("User just logged in via Facebook")
            guard let accessTokenString = FBSDKAccessToken.current().tokenString else {
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if (error != nil) {
                    SVProgressHUD.dismiss()
                    print("Facebook authentication failed")
                } else {
                    SVProgressHUD.dismiss()
                    print("Facebook authentication succeed")
                    let user = Auth.auth().currentUser
                    if let user = user {
                        _ = user.uid
                     //   let ph:String? = user.phoneNumber
                        let email:String? = user.email
                        
                        let username:String = user.displayName!
                        let defaults = UserDefaults.standard
                        
                        defaults.set(username, forKey: "FULLNAME")
                        defaults.set(email, forKey: "EMAIL")
                        defaults.synchronize()
                        Customer.firstName = username
                        
                       // Customer.email = email
                    }
                    
                    AsyncTask.socialRegister()
                    let defaults = UserDefaults.standard
                    defaults.set(true, forKey: "isRegIn")
                    defaults.synchronize()
                    
                    let mainStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
                    let protectedPage = mainStoryBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                    let appDelegate = UIApplication.shared.delegate
                    appDelegate?.window??.rootViewController = protectedPage
                }
            })
        } else {
            print("An error occured the user couldn't log in")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User just logged out from his Facebook account")
    }
    
    fileprivate func configureFacebookSignInButton() {
       // let facebookSignInButton = FBSDKLoginButton()
     
        facebookSignInButton.delegate = self
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func configureGoogleSignInButton() {

        
            GIDSignIn.sharedInstance().uiDelegate = self
        
       // GIDSignIn.sharedInstance().delegate = self as! GIDSignInDelegate
    }
}
