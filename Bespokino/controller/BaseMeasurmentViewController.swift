//
//  BaseMeasurmentViewController.swift
//  Bespokino
//
//  Created by Bespokino on 22/2/2561 BE.
//  Copyright © 2561 bespokinoapp. All rights reserved.
//

import UIKit

class BaseMeasurmentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  //  @IBOutlet weak var noMeasurmentLabel: UILabel!
    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    let defaults = UserDefaults.standard

    @IBOutlet weak var baseToolTableViewController: UITableView!
    
    @IBOutlet weak var postureLabek: UILabel!
    @IBOutlet weak var shoulderLabel: UILabel!
    @IBOutlet weak var chestLabel: UILabel!
    @IBOutlet weak var abdomeLabel: UILabel!
    @IBOutlet weak var pelvisLabel: UILabel!
    @IBOutlet weak var pantsWaistLabel: UILabel!
    
   
    
    let item = ["SHOULDER","SLEEVE","CHEST","WAIST","HIPS","BICEPS","COLLAR","CUFF","LENGTH"]

    var value = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        baseToolTableViewController.tableFooterView = UIView()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        //noMeasurmentLabel.isHidden = false
        self.baseToolTableViewController.isHidden = false
         let yesMeasure = defaults.bool(forKey: "MEASURMENT")
        self.navigationItem.title = "BESPOKINO"
        baseToolTableViewController.tableFooterView = UIView()
        
        let yesBody = defaults.bool(forKey: "YESBODY")
        
        if yesBody{
            
            let posture =  defaults.string(forKey: "POSTURE")
            let shoulder = defaults.string(forKey: "SHOULDERB")
            let chest = defaults.string(forKey: "CHESTB")
            let abdomen = defaults.string(forKey: "ABDOMEN")
            let pelvis = defaults.string(forKey: "PELVIS")
            let pantwaistsize = defaults.string(forKey:"PANTWAISTSIZE")

            
            self.postureLabek.text = posture!.uppercased()
            self.shoulderLabel.text = shoulder!.uppercased()
            self.chestLabel.text = chest!.uppercased()
            self.abdomeLabel.text = abdomen!.uppercased()
            self.pelvisLabel.text = pelvis!.uppercased()
            self.pantsWaistLabel.text = pantwaistsize!.uppercased()

            
            
            
        }

        if yesMeasure{
            //noMeasurmentLabel.isHidden = true

            let rightBarButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.myRightSideBarButtonItemTapped(_:)))
            self.navigationItem.rightBarButtonItem = rightBarButton
            let shoulder = defaults.string(forKey: "SHOULDER")
            let sleeve = defaults.string(forKey: "SLEEVE")
            let chest = defaults.string(forKey: "CHEST")
            let waists = defaults.string(forKey: "WAIST")
            let hips = defaults.string(forKey: "HIPS")
            let biceps = defaults.string(forKey: "BICEPS")
            let collar = defaults.string(forKey: "NECK")
            let cuff = defaults.string(forKey: "CUFF")
            let length = defaults.string(forKey: "LENGTH")
            
            value = [shoulder!,sleeve!,chest!,waists!,hips!,biceps!,collar!,cuff!,length!]
        }else{
            //noMeasurmentLabel.isHidden = false
 self.baseToolTableViewController.isHidden = true
            
            let rightBarButton = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.myRightSideBarButtonItemTapped(_:)))
            self.navigationItem.rightBarButtonItem = rightBarButton
        }
      
    

        if self.revealViewController() != nil {
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        btnMenuButton.target = revealViewController()
        btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
   
        
    
    }
    @objc func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MeasurmentParentViewController") as! MeasurmentParentViewController
        
        
        
        self.navigationController?.pushViewController(newViewController, animated: true)    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MeasurmentTableViewCell
         let yesMeasure = defaults.bool(forKey: "MEASURMENT")
        if yesMeasure{
            cell.itemName.text = item[indexPath.row]
            cell.imageCode.image = UIImage(named:self.value[indexPath.row])
        }
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
