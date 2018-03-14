//
//  ToolStatusViewController.swift
//  Bespokino
//
//  Created by Bespokino on 19/2/2561 BE.
//  Copyright © 2561 bespokinoapp. All rights reserved.
//

import UIKit

class ToolStatusViewController: UIViewController {
  
    @IBOutlet weak var toolPresentView: UIView!
    @IBOutlet weak var sendMetoolView: UIView!
    
    @IBOutlet weak var presentMarker: UIImageView!
    @IBOutlet weak var sendMarker: UIImageView!
    let defaults = UserDefaults.standard

    @IBOutlet weak var modelNumberLabel: UILabel!
    var modelNumber:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "BESPOKINO"

        print(modelNumber!)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)

        let toolPresentView = UITapGestureRecognizer(target: self, action: #selector(toolPresentAction))
        let sendMetoolView = UITapGestureRecognizer(target: self, action: #selector(sendMetoolAction))
        
        self.toolPresentView.addGestureRecognizer(toolPresentView)
        self.sendMetoolView.addGestureRecognizer(sendMetoolView)
        
        self.presentMarker.isHidden = true
        self.sendMarker.isHidden = true
        
        let rightBarButton = UIBarButtonItem(title: "Home", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.myRightSideBarButtonItemTapped(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton

        let modelnumber = defaults.string(forKey: "MODELNO")
        self.modelNumberLabel.text = "BESPOKINO SHIRT MODEL NUMBER : \(modelnumber!)"
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let modelnumber = defaults.string(forKey: "MODELNO")
        self.modelNumberLabel.text = "BESPOKINO SHIRT MODEL NUMBER : \(modelnumber!)"
    }
    
    @objc func toolPresentAction(sender:UITapGestureRecognizer){
        
        let yesMeasure = defaults.bool(forKey: "MEASURMENT")
        
        if yesMeasure{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "InvoiceViewController") as! InvoiceViewController
            
            
            
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else{
            print("tool present")
            self.presentMarker.isHidden = false
            self.sendMarker.isHidden = true
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "MeasurmentParentViewController") as! MeasurmentParentViewController
      
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    @objc func sendMetoolAction(sender:UITapGestureRecognizer){
        print("send me tool")
        self.presentMarker.isHidden = true
        self.sendMarker.isHidden = false
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "BillingViewController") as! BillingViewController

        newViewController.PAY_TAG = "TWENTY"
        self.navigationController?.pushViewController(newViewController, animated: true)
        

    }
    @objc func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        
        self.present(newViewController, animated: true, completion: nil)
        //  self.navigationController?.pushViewController(newViewController, animated: true)
    }
}
