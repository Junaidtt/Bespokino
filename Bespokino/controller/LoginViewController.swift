//
//  LoginViewController.swift
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


class LoginViewController: UIViewController,UITextFieldDelegate,GIDSignInUIDelegate,FBSDKLoginButtonDelegate {

    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordtextField: UITextField!
    
    @IBOutlet weak var facebookSignInButton: FBSDKLoginButton!
    
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    let async:AsyncTask = AsyncTask()
    
    override func viewDidLoad() {
        super.viewDidLoad()

            let defaults = UserDefaults.standard
            let isRegIn = defaults.bool(forKey: "isRegIn")
        if isRegIn{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            
            self.present(newViewController, animated: true, completion: nil)
            
            // self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
        
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationItem.title = "BESPOKINO"
        
        
        
        configureGoogleSignInButton()
        GIDSignIn.sharedInstance().uiDelegate = self
      
        
        facebookSignInButton.layer.cornerRadius = 3.0
        facebookSignInButton.layer.masksToBounds = true
        facebookSignInButton.layer.borderColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        facebookSignInButton.layer.borderWidth = 0.3
        facebookSignInButton.layer.shadowColor = UIColor.black.cgColor
        facebookSignInButton.layer.shadowOpacity = 1
        facebookSignInButton.layer.shadowOffset = CGSize.zero
        facebookSignInButton.layer.shadowRadius = 10
        
        
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.statusBarStyle = .default
        
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        
//        let firebaseAuth = Auth.auth()
       // GIDSignIn.sharedInstance().signOut()

//        do {
//            try firebaseAuth.signOut()
//            FBSDKLoginManager().logOut()
//        } catch let signOutError as NSError {
//            print ("Error signing out: %@", signOutError)
//        }
        
        
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
       
            self.present(newViewController, animated: true, completion: nil)
            
           // self.navigationController?.pushViewController(newViewController, animated: true)
            
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
    //FBSDKLoginButton delegate methods
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        SVProgressHUD.show()
        if error == nil {
          
            print("User just logged in via Facebook")
            if FBSDKAccessToken.current() != nil{
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
    
                            guard let username:String = user.displayName else {return}
                            
                            let email:String? = user.email
                            print(email ?? "No EMAIL")
                            let uniqueid:String = user.uid
                            let fullname:String = user.displayName!
                            
                            let async = AsyncTask()
                            async.socialRegister(fullname: fullname, uniqueid: uniqueid+"fb")
                            
                            Customer.firstName = username
                            
                            let defaults = UserDefaults.standard
                            
                            defaults.set(username, forKey: "FULLNAME")
                            //  defaults.set(email, forKey: "EMAIL")
                            defaults.synchronize()
                            //Customer.email = email
                        }
                        
                      
                        
                        
                        let defaults = UserDefaults.standard
                        defaults.set(true, forKey: "isRegIn")
                        defaults.synchronize()
                        
                        let mainStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
                        let protectedPage = mainStoryBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                        let appDelegate = UIApplication.shared.delegate
                        appDelegate?.window??.rootViewController = protectedPage
                    }
                })
         }
           
            SVProgressHUD.dismiss()
        } else {
            print("An error occured the user couldn't log in")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User just logged out from his Facebook account")
    }
    
    fileprivate func configureFacebookSignInButton() {
        
        facebookSignInButton.delegate = self
    }
    
    fileprivate func configureGoogleSignInButton() {
  
        GIDSignIn.sharedInstance().uiDelegate = self
      //  GIDSignIn.sharedInstance().signIn()

   
    }
}
