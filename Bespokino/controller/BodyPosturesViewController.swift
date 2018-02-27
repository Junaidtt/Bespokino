//
//  BodyPosturesViewController.swift
//  Bespokino
//
//  Created by Bespokino on 11/22/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import Firebase
import SVProgressHUD
class BodyPosturesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    
    struct Model {
        
        var image:UIImage
        var name:String
        var itemCode:String
        
        init(img:UIImage,n:String,code:String) {
            
            self.image = img
            self.name = n
            self.itemCode = code
            
        }
        
    }
    let defaults = UserDefaults.standard

    @IBOutlet weak var bodyTableView: UITableView!
    
   // @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var posture = [Model]()
    var shoulder = [Model]()
    var chest = [Model]()
    var abdomen = [Model]()
    var pelvis = [Model]()
    
    var activedata = [Model]()
    var FLAG:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        let posture =  defaults.string(forKey: "POSTURECODE")
//        let shoulder = defaults.string(forKey: "SHOULDERCODE")
//        let chest = defaults.string(forKey: "CHESTCODE")
//        let abdomen = defaults.string(forKey: "ABDOMENCODE")
//        let pelvis = defaults.string(forKey: "PELVISCODE")
        
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        self.navigationItem.title = "BESPOKINO"
        
        self.titleLabel.text = "POSTURE"
        

        self.FLAG = "POSTURE"
        
        let posture1 = Model(img: UIImage(named: "posture_erect")!, n: "NORMAL",code:"posture-Normal")
        let posture2 = Model(img: UIImage(named: "posture_leaning")!, n: "LEANING",code:"posture-LEANING")
        let posture3 = Model(img: UIImage(named: "posture_erect")!, n: "ERACT",code:"posture-ERACT")
        posture.append(posture1)
        posture.append(posture2)
        posture.append(posture3)

        let shoulder1 = Model(img: UIImage(named: "shoulders_steep")!, n: "STEEP",code:"shoulders-STEAP")
        let shoulder2 = Model(img: UIImage(named: "shoulders_normal")!, n: "NORMAL",code:"shoulders-LEANING")
        let shoulder3 = Model(img: UIImage(named: "shoulders_flat")!, n: "FLAT",code:"shoulders-FLAT")
              shoulder.append(shoulder1)
              shoulder.append(shoulder2)
              shoulder.append(shoulder3)
        //  [UIImage(named: "chest_thin")!,UIImage(named: "chest_fit")!,UIImage(named: "chest_normal")!,UIImage(named: "chest_muscular")!,UIImage(named: "chest_large")!],
        let chest1 = Model(img: UIImage(named: "chest_thin")!, n: "THIN",code:"chest-THIN")
        let chest2 = Model(img: UIImage(named: "chest_fit")!, n: "FIT",code:"chest-FIT")
        let chest3 = Model(img: UIImage(named: "chest_normal")!, n: "NORMAL",code:"chest-NORMAL")
        let chest4 = Model(img: UIImage(named: "chest_muscular")!, n: "MUSCULAR",code:"chest-MUSCULAR")
        let chest5 = Model(img: UIImage(named: "chest_large")!, n: "LARGE",code:"chest-LARGE")

         chest.append(chest1)
         chest.append(chest2)
         chest.append(chest3)
         chest.append(chest4)
         chest.append(chest5)
        
        //[UIImage(named: "abdomen_thin")!,UIImage(named: "abdomen_normal")!,UIImage(named: "abdomen_medium")!,UIImage(named: "abdomen_large")!],

        let abdomen1 = Model(img: UIImage(named: "abdomen_thin")!, n: "THIN",code:"abdomen-THIN")
        let abdomen2 = Model(img: UIImage(named: "abdomen_normal")!, n: "NORMAL",code:"abdomen-NORMAL")
        let abdomen3 = Model(img: UIImage(named: "abdomen_medium")!, n: "MEDIUM",code:"abdomen-MEDIUM")
        let abdomen4 = Model(img: UIImage(named: "abdomen_large")!, n: "LARGE",code:"abdomen-LARGE")

        abdomen.append(abdomen1)
        abdomen.append(abdomen2)
        abdomen.append(abdomen3)
        abdomen.append(abdomen4)


        // [UIImage(named: "pelvis_thin")!,UIImage(named: "pelvis_normal")!,UIImage(named: "pelvis_curved")!,UIImage(named: "pelvis_large")!]

        let pelvis1 = Model(img: UIImage(named: "pelvis_thin")!, n: "THIN",code:"pelvis-THIN")
        let pelvis2 = Model(img: UIImage(named: "pelvis_normal")!, n: "NORMAL",code:"pelvis-NORMAL")
        let pelvis3 = Model(img: UIImage(named: "pelvis_curved")!, n: "CURVED",code:"pelvis-CURVED")
        let pelvis4 = Model(img: UIImage(named: "pelvis_large")!, n: "LARGE",code:"pelvis-LARGE")

        pelvis.append(pelvis1)
        pelvis.append(pelvis2)

        pelvis.append(pelvis3)

        pelvis.append(pelvis4)

         activedata = posture

  
    }

   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return activedata.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BodyPostureTableViewCell
        
        cell.selectionStyle = .default
        
        cell.bodyLabel.text = activedata[indexPath.row].name
        cell.bodyPostureImage.image = activedata[indexPath.row].image
        cell.bodyView.layer.cornerRadius = 6
        cell.bodyView.layer.masksToBounds = true
         cell.marker.isHidden = true
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = backgroundView
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell:BodyPostureTableViewCell = tableView.cellForRow(at: indexPath) as! BodyPostureTableViewCell
        cell.marker.isHidden = false
        cell.marker.image = UIImage(named:"tick")!
        if FLAG == "POSTURE"{
           SVProgressHUD.show()
            let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
              
                self.FLAG = "SHOULDER"
                self.titleLabel.text = "SHOULDER"
                BodyPosture.posture = self.activedata[indexPath.row].itemCode
                self.defaults.set(self.activedata[indexPath.row].name, forKey: "POSTURE")
                self.defaults.set(self.activedata[indexPath.row].itemCode, forKey: "POSTURECODE")
                print(self.activedata[indexPath.row].name)
                self.activedata = self.shoulder
                SVProgressHUD.dismiss()
                self.bodyTableView.reloadData()
            }
          
        }
       else if FLAG == "SHOULDER"{
            SVProgressHUD.show()
            let when = DispatchTime.now() + 1 // change 1 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
              
                BodyPosture.shoulder = self.activedata[indexPath.row].itemCode
                self.defaults.set(self.activedata[indexPath.row].name, forKey: "SHOULDERB")
                self.defaults.set(self.activedata[indexPath.row].itemCode, forKey: "SHOULDERCODE")

                self.FLAG = "CHEST"
                self.titleLabel.text = "CHEST"
                  self.activedata = self.chest
                SVProgressHUD.dismiss()
                self.bodyTableView.reloadData()            }
          
        }else if FLAG == "CHEST"{
            SVProgressHUD.show()
            let when = DispatchTime.now() + 1 // change 1 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                BodyPosture.chest = self.activedata[indexPath.row].itemCode
                self.defaults.set(self.activedata[indexPath.row].name, forKey: "CHESTB")
                self.defaults.set(self.activedata[indexPath.row].itemCode, forKey: "CHESTCODE")

                self.FLAG = "ABDOMEN"
                self.titleLabel.text = "ABDOMEN"
                self.activedata = self.abdomen
                SVProgressHUD.dismiss()
                self.bodyTableView.reloadData()
            }
           
        }else if FLAG == "ABDOMEN"{
            SVProgressHUD.show()
            let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.FLAG = "PELVIS"
                self.titleLabel.text = "PELVIS"
                 BodyPosture.abdomen = self.activedata[indexPath.row].itemCode
                self.defaults.set(self.activedata[indexPath.row].name, forKey: "ABDOMEN")
                self.defaults.set(self.activedata[indexPath.row].itemCode, forKey: "ABDOMENCODE")

                self.activedata = self.pelvis
                 SVProgressHUD.dismiss()
                self.bodyTableView.reloadData()
                
            }
     
        }else if FLAG == "PELVIS"{
            SVProgressHUD.show()
            let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.activedata = self.pelvis
                BodyPosture.pelvis = self.activedata[indexPath.row].itemCode
                self.defaults.set(self.activedata[indexPath.row].name, forKey: "PELVIS")
                self.defaults.set(self.activedata[indexPath.row].itemCode, forKey: "PELVISCODE")

                self.defaults.set(true, forKey: "YESBODY")

              //  self.FLAG = "POSTURE"
                // self.continueButton.setTitleColor(.white, for: .normal)
              //  self.titleLabel.text = "PELVIS"
                SVProgressHUD.dismiss()
                self.bodyTableView.reloadData()
            }
         
         
            
    
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "FitViewController") as! FitViewController
        
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
    
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell:BodyPostureTableViewCell = tableView.cellForRow(at: indexPath) as! BodyPostureTableViewCell
        
       // cell.marker.image = UIImage(named:"")
        cell.marker.isHidden = true
    }
    
//    @objc func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
//    {
//        print("myRightSideBarButtonItemTapped")
//
//        do {
//            try Auth.auth().signOut()
//
////            let signInPage = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
////            let appDelegate = UIApplication.shared.delegate
////            appDelegate?.window??.rootViewController = signInPage
//
//                //self.dismiss(animated: true, completion: nil)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//            let sw = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
//
//            self.view.window?.rootViewController = sw
//
//            let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
//
//            let navigationController = UINavigationController(rootViewController: destinationController)
//
//            sw.pushFrontViewController(navigationController, animated: true)
//
//        } catch let signOutError as NSError {
//            print ("Error signing out: %@", signOutError)
//        }
//    }
    
//    @objc func myLeftSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
//    {
//        print("myLeftSideBarButtonItemTapped")
//    }
    
}
