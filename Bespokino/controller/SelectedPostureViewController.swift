//
//  SelectedPostureViewController.swift
//  Bespokino
//
//  Created by Bespokino on 23/2/2561 BE.
//  Copyright © 2561 bespokinoapp. All rights reserved.
//

import UIKit

class SelectedPostureViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var noSelectLabel: UILabel!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    let defaults = UserDefaults.standard
    var selectedBodyPosture = [String]()
    var item = ["POSTURE","SHOULDER","CHEST","ABDOMEN","PELVIS"]
    @IBOutlet weak var postureSelectiontableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.title = "BESPOKINO"
        postureSelectiontableView.tableFooterView = UIView()
        noSelectLabel.isHidden = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        
        
        if self.revealViewController() != nil {
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        
        let yesBody = defaults.bool(forKey: "YESBODY")
        
        if yesBody{
            noSelectLabel.isHidden = true

            let rightBarButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.myRightSideBarButtonItemTapped(_:)))
            self.navigationItem.rightBarButtonItem = rightBarButton
            let posture =  defaults.string(forKey: "POSTURE")
            let shoulder = defaults.string(forKey: "SHOULDER")
            let chest = defaults.string(forKey: "CHEST")
            let abdomen = defaults.string(forKey: "ABDOMEN")
            let pelvis = defaults.string(forKey: "PELVIS")
            
            
            selectedBodyPosture = [posture!,shoulder!,chest!,abdomen!,pelvis!]
        }else{
            
            noSelectLabel.isHidden = false

            let rightBarButton = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.myRightSideBarButtonItemTapped(_:)))
            self.navigationItem.rightBarButtonItem = rightBarButton
            self.postureSelectiontableView.isHidden = true
        }
        
    }
    
    
    @objc func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
    {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "BodyPosturesViewController") as! BodyPosturesViewController
      self.navigationController?.pushViewController(newViewController, animated: true)
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedBodyPosture.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "posture", for: indexPath) as! PostureTableViewCell
        
        cell.postureItem.text = item[indexPath.row].capitalized
        
        cell.postureValue.text = selectedBodyPosture[indexPath.row].capitalized
        
        return cell
        
    }
    

   

}
