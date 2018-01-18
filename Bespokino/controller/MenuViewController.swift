//
//  MenuViewController.swift
//  Bespokino
//
//  Created by Bespokino on 11/10/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var menuTableView: UITableView!

    
    var menu = ["HOME","ABOUT US","LOGOUT","RATE ME"]
    
    var picture:[UIImage] = [
        UIImage(named: "home")!,
        UIImage(named: "info")!,
         UIImage(named: "ordering")!,
        UIImage(named: "star")!
       ]
 
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.menuTableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      UIApplication.shared.statusBarStyle = .default
        
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
         statusBar.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
//        if statusBar.respondsToSelector("setBackgroundColor:") {
//            statusBar.backgroundColor = UIColor.red
//        }

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
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.yellow
        cell.selectedBackgroundView = backgroundView
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell1 = tableView.cellForRow(at: indexPath)

        //cell1?.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
       // cell1?.layer.borderWidth = 2
        
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

            defaults.synchronize()
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ParentViewController") as! ParentViewController
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
