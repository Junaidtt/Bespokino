//
//  MenuViewController.swift
//  Bespokino
//
//  Created by Bespokino on 11/10/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit
class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var menuTableView: UITableView!

    @IBOutlet weak var userTitle: UILabel!
    
    let defaults = UserDefaults.standard
    var menu = ["HOME","ABOUT US","RATE ME","BESPOKE PROFILE","LOGOUT"]
    
    var picture:[UIImage] = [
        UIImage(named: "home")!,
        UIImage(named: "info")!,
        UIImage(named: "star")!,
        UIImage(named: "measure")!,
        UIImage(named: "ordering")!
        
       ]
 
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.menuTableView.tableFooterView = UIView()
        
        userTitle.text = "\(String(describing: defaults.string(forKey: "FULLNAME")!))"

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      UIApplication.shared.statusBarStyle = .default
        
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
         statusBar.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        
        self.menuTableView.reloadData()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuTableViewCell
        
        cell.menulabel.text = menu[indexPath.row]
        
        cell.menuImage.image = picture[indexPath.row]
        
        
        
        let yesBody = defaults.bool(forKey: "YESBODY")
        
        if yesBody{
            if cell.menulabel.text == "BESPOKE PROFILE"{
                
                cell.bespokeProfileImage.image = UIImage(named:"verified")

            }

        }
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.yellow
        cell.selectedBackgroundView = backgroundView
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        //SELECT ACTION
          let revealViewController:SWRevealViewController = self.revealViewController()
         let cell:MenuTableViewCell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
      //  cell.menulabel.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        

        if cell.menulabel.text == "HOME"{
            
            print("Home")
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ParentViewController") as! ParentViewController
         let newFrontViewController = UINavigationController.init(rootViewController: newViewController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }else if cell.menulabel.text == "ABOUT US"{
            print("ABOUT")

            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
            let newFrontViewController = UINavigationController.init(rootViewController: newViewController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        
        }else if cell.menulabel.text == "LOGOUT"{
            let defaults = UserDefaults.standard
            defaults.set(false, forKey: "isRegIn")
            defaults.set(false, forKey: "isLoggedIn")
  
            defaults.removeObject(forKey: "FULLNAME")
            defaults.removeObject(forKey: "EMAIL")

            defaults.synchronize()
            
            GIDSignIn.sharedInstance().signOut()

            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                FBSDKLoginManager().logOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            
            //Remove USER DEFAULT VALUES
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()

            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController

            self.navigationController?.pushViewController(newViewController, animated: true)
            self.present(newViewController, animated: true, completion: nil)
            
            
            
        }else if cell.menulabel.text == "BESPOKE PROFILE"{
           
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "BaseMeasurmentViewController") as! BaseMeasurmentViewController
            let newFrontViewController = UINavigationController.init(rootViewController: newViewController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            

        }
        else if cell.menulabel.text == "RATE ME"{

            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ParentViewController") as! ParentViewController
            let newFrontViewController = UINavigationController.init(rootViewController: newViewController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            
            
            let delegate = AppDelegate()
            delegate.requestReview()
            
    
            
        }

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.yellow
        cell.selectedBackgroundView = backgroundView
        
    }
   func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
  //  cell?.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
  //  cell?.layer.borderWidth = 0
    let backgroundView = UIView()
    backgroundView.backgroundColor = UIColor.black
    cell?.selectedBackgroundView = backgroundView
    
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(40)
    }
    
   
    
}
