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
    @IBOutlet weak var casualLabel: UILabel!
    @IBOutlet weak var slimLabel: UILabel!
    
    var slim:Int = 0
    var fit:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.navigationItem.title = "BESPOKINO"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        let casualGesture = UITapGestureRecognizer(target: self, action: #selector(casualAction))
        let slimGesture = UITapGestureRecognizer(target: self, action: #selector(slimAction))

        self.casualView.addGestureRecognizer(casualGesture)
        self.slimView.addGestureRecognizer(slimGesture)
    
        self.casualLabel.text = "Your Bespokino Self-Measuring Tool Size is:\(Order.modelNo)"
         self.slimLabel.text = "Your Bespokino Self-Measuring Tool Size is:\(Order.modelNo+1)"
    
    }
    @objc func casualAction(sender:UITapGestureRecognizer){
       print("casual view selected")
        
        self.fit = 1
        self.slim = 0
        casualView.layer.borderWidth = 2
        casualView.layer.borderColor = #colorLiteral(red: 1, green: 0.8000000119, blue: 0.400000006, alpha: 1)
        
        slimView.layer.borderWidth = 2
        slimView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        slimTicke.image = UIImage(named: "")

        casualTick.image = UIImage(named: "tick")
    }
    @objc func slimAction(sender:UITapGestureRecognizer){
        print("slim view selected")
        self.fit = 0
        self.slim = 1
        slimView.layer.borderWidth = 2
        slimView.layer.borderColor = #colorLiteral(red: 1, green: 0.8000000119, blue: 0.400000006, alpha: 1)
        
        casualView.layer.borderWidth = 2
        casualView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        casualTick.image = UIImage(named: "")

        slimTicke.image = UIImage(named: "tick")
    }


    @IBAction func measuringToolPresent(_ sender: Any) {
        
        
        if self.slim != 0 || self.fit != 0{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "MeasurmentParentViewController") as! MeasurmentParentViewController
            
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else{
            
            self.displayAlertMessage(messageToDisplay: "please select your preffered fit")
        }
        
      
        
    }
    
    
    @IBAction func sendMeMeasuringTool(_ sender: Any) {
        
        if self.slim != 0 || self.fit != 0{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "PayTwentyViewController") as! PayTwentyViewController
            
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else{
            self.displayAlertMessage(messageToDisplay: "please select your preffered fit")

            
        }

        
    }
    func displayAlertMessage(messageToDisplay: String)
    {
        let alertController = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
  

}
