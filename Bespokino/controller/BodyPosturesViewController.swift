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
        
        init(img:UIImage,n:String) {
            
            self.image = img
            self.name = n
            
            
        }
        
    }
    @IBOutlet weak var bodyTableView: UITableView!
    
    @IBOutlet weak var continueButton: UIButton!
    
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
       
        continueButton.layer.cornerRadius = 3.0
        continueButton.layer.masksToBounds = true
        self.FLAG = "SHOULDER"
        let posture1 = Model(img: UIImage(named: "posture_erect")!, n: "ERECT")
        let posture2 = Model(img: UIImage(named: "posture_leaning")!, n: "LINEAR")
        let posture3 = Model(img: UIImage(named: "posture_erect")!, n: "LINEAR")
        posture.append(posture1)
        posture.append(posture2)
        posture.append(posture3)
        
        
        let shoulder1 = Model(img: UIImage(named: "shoulders_steep")!, n: "STEEP")
         let shoulder2 = Model(img: UIImage(named: "shoulders_normal")!, n: "NORMAL")
         let shoulder3 = Model(img: UIImage(named: "shoulders_flat")!, n: "FLAT")
        
              shoulder.append(shoulder1)
              shoulder.append(shoulder2)
              shoulder.append(shoulder3)
        
        //  [UIImage(named: "chest_thin")!,UIImage(named: "chest_fit")!,UIImage(named: "chest_normal")!,UIImage(named: "chest_muscular")!,UIImage(named: "chest_large")!],
        let chest1 = Model(img: UIImage(named: "chest_thin")!, n: "THIN")
        let chest2 = Model(img: UIImage(named: "chest_fit")!, n: "FIT")
        let chest3 = Model(img: UIImage(named: "chest_normal")!, n: "NORMAL")
        let chest4 = Model(img: UIImage(named: "chest_muscular")!, n: "MUSCULAR")
        let chest5 = Model(img: UIImage(named: "chest_large")!, n: "LARGE")

        chest.append(chest1)
         chest.append(chest2)
         chest.append(chest3)
         chest.append(chest4)
         chest.append(chest5)
        
        //[UIImage(named: "abdomen_thin")!,UIImage(named: "abdomen_normal")!,UIImage(named: "abdomen_medium")!,UIImage(named: "abdomen_large")!],
        
        let abdomen1 = Model(img: UIImage(named: "abdomen_thin")!, n: "THIN")
        let abdomen2 = Model(img: UIImage(named: "abdomen_normal")!, n: "NORMAL")
        let abdomen3 = Model(img: UIImage(named: "abdomen_medium")!, n: "MEDIUM")
        let abdomen4 = Model(img: UIImage(named: "abdomen_large")!, n: "LARGE")


        abdomen.append(abdomen1)
        abdomen.append(abdomen2)
        abdomen.append(abdomen3)
        abdomen.append(abdomen4)


        // [UIImage(named: "pelvis_thin")!,UIImage(named: "pelvis_normal")!,UIImage(named: "pelvis_curved")!,UIImage(named: "pelvis_large")!]

        let pelvis1 = Model(img: UIImage(named: "pelvis_thin")!, n: "THIN")
        let pelvis2 = Model(img: UIImage(named: "pelvis_normal")!, n: "NORMAL")
        let pelvis3 = Model(img: UIImage(named: "pelvis_curved")!, n: "CURVED")
        let pelvis4 = Model(img: UIImage(named: "pelvis_large")!, n: "LARGE")

        pelvis.append(pelvis1)
        pelvis.append(pelvis2)

        pelvis.append(pelvis3)

        pelvis.append(pelvis4)

        
         activedata = posture

        
    
    }
   @objc func rightButtonAction(sender: UIBarButtonItem){
        
        print("right button")
    
        activedata = posture
    
    self.FLAG = "SHOULDER"
    self.titleLabel.text = "POSTURE"
   self.bodyTableView.reloadData()
    self.continueButton.setTitleColor(.gray, for: .normal)

    
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let rightButtonItem = UIBarButtonItem.init(
            title: "refresh",
            style: .done,
            target: self,
            action: #selector(rightButtonAction)
        )
        
        self.navigationItem.rightBarButtonItem = rightButtonItem
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
        cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

       // let cell = tableView.cellForRow(at: indexPath)
        
        //cell?.layer.borderWidth = 2
        //cell?.layer.borderColor = #colorLiteral(red: 1, green: 0.8000000119, blue: 0.400000006, alpha: 1)
        
        if FLAG == "SHOULDER"{
            activedata = shoulder
            self.FLAG = "CHEST"
            self.titleLabel.text = "SHOULDER"
            self.bodyTableView.reloadData()
        }else if FLAG == "CHEST"{
            activedata = chest
            self.FLAG = "ABDOMEN"
            self.titleLabel.text = "CHEST"
            self.bodyTableView.reloadData()
        }else if FLAG == "ABDOMEN"{
            activedata = abdomen
            self.FLAG = "PELVIS"
            self.titleLabel.text = "ABDOMEN"
            self.bodyTableView.reloadData()
        }else if FLAG == "PELVIS"{
            activedata = pelvis
            self.FLAG = "DEFAULT"
            self.continueButton.setTitleColor(.white, for: .normal)
            self.titleLabel.text = "PELVIS"
            self.bodyTableView.reloadData()
        }

        
        
    }
    @IBAction func continueButtonDidTap(_ sender: Any) {
        
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FitViewController") as! FitViewController
        
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
}
