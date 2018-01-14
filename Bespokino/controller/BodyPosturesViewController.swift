//
//  BodyPosturesViewController.swift
//  Bespokino
//
//  Created by Bespokino on 11/22/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

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

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        self.navigationItem.title = "BESPOKINO"
        
        self.titleLabel.text = "POSTURE"
//
//        continueButton.layer.cornerRadius = 3.0
//        continueButton.layer.masksToBounds = true
        self.FLAG = "POSTURE"
        let posture1 = Model(img: UIImage(named: "posture_erect")!, n: "NORMAL",code:"posture-Normal")
        let posture2 = Model(img: UIImage(named: "posture_leaning")!, n: "LINEAR",code:"posture-LEANING")
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
        
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = backgroundView
        return cell
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if FLAG == "SHOULDER"{
            activedata = shoulder
            BodyPosture.shoulder = self.activedata[indexPath.row].itemCode
            self.FLAG = "CHEST"
            self.titleLabel.text = "SHOULDER"
            self.bodyTableView.reloadData()
        }else if FLAG == "CHEST"{

            activedata = chest
            self.FLAG = "ABDOMEN"
            self.titleLabel.text = "CHEST"
            BodyPosture.chest = self.activedata[indexPath.row].itemCode

            self.bodyTableView.reloadData()
        }else if FLAG == "ABDOMEN"{
            

            activedata = abdomen
            self.FLAG = "PELVIS"
            BodyPosture.abdomen = self.activedata[indexPath.row].itemCode
            self.titleLabel.text = "ABDOMEN"
            self.bodyTableView.reloadData()
        }else if FLAG == "PELVIS"{
            activedata = pelvis
            BodyPosture.pelvis = self.activedata[indexPath.row].itemCode

            self.FLAG = "DEFAULT"
         //   self.continueButton.setTitleColor(.white, for: .normal)
            self.titleLabel.text = "PELVIS"
           //self.bodyTableView.reloadData()
            let body = Body()
            body.postBodyPosture()
            
    
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "FitViewController") as! FitViewController
            
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else if FLAG == "POSTURE"{
            self.FLAG = "SHOULDER"
            activedata = posture
            BodyPosture.posture = self.activedata[indexPath.row].itemCode
self.bodyTableView.reloadData()
        }

        
        
        
    }

    
}
