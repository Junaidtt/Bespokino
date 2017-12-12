//
//  FitViewController.swift
//  Bespokino
//
//  Created by Bespokino on 11/22/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class FitViewController: UIViewController {

    @IBOutlet weak var casualView: UIView!
    @IBOutlet weak var slimView: UIView!
    @IBOutlet weak var slimTicke: UIImageView!
    @IBOutlet weak var casualTick: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.navigationItem.title = "BESPOKINO"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        let casualGesture = UITapGestureRecognizer(target: self, action: #selector(casualAction))
        let slimGesture = UITapGestureRecognizer(target: self, action: #selector(slimAction))

        self.casualView.addGestureRecognizer(casualGesture)
        self.slimView.addGestureRecognizer(slimGesture)
    
    
    }
    @objc func casualAction(sender:UITapGestureRecognizer){
       print("casual view selected")
        
        casualView.layer.borderWidth = 2
        casualView.layer.borderColor = #colorLiteral(red: 1, green: 0.8000000119, blue: 0.400000006, alpha: 1)
        
        slimView.layer.borderWidth = 2
        slimView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        slimTicke.image = UIImage(named: "")

        casualTick.image = UIImage(named: "tick")
    }
    @objc func slimAction(sender:UITapGestureRecognizer){
        print("slim view selected")
        
        slimView.layer.borderWidth = 2
        slimView.layer.borderColor = #colorLiteral(red: 1, green: 0.8000000119, blue: 0.400000006, alpha: 1)
        
        casualView.layer.borderWidth = 2
        casualView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        casualTick.image = UIImage(named: "")

        slimTicke.image = UIImage(named: "tick")
    }


    @IBAction func measuringToolPresent(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MeasurmentParentViewController") as! MeasurmentParentViewController
        
        self.navigationController?.pushViewController(newViewController, animated: true)
        
        
        
        
    }
    
    
    @IBAction func sendMeMeasuringTool(_ sender: Any) {
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "PayTwentyViewController") as! PayTwentyViewController
        
        self.navigationController?.pushViewController(newViewController, animated: true)
        
        
        
        
    }
    
  

}
