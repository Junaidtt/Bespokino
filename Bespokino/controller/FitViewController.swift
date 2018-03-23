//
//  FitViewController.swift
//  Bespokino
//
//  Created by Bespokino on 11/22/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class FitViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
 
    @IBOutlet weak var casualView: UIView!
    @IBOutlet weak var slimView: UIView!
    @IBOutlet weak var slimTicke: UIImageView!
    @IBOutlet weak var casualTick: UIImageView!
    @IBOutlet weak var casualLabel: UILabel!
    @IBOutlet weak var slimLabel: UILabel!
    @IBOutlet weak var modelTextField: UITextField!
    var modelNumber:String = ""
    var model =  ["27","28","29","30","31","32","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49"]
    var pantWaistSize:String?
    let picker = UIPickerView()
    var slim:Int = 0
    var fit:Int = 0
    
    @IBOutlet weak var topViewLength: NSLayoutConstraint!
    let defaults = UserDefaults.standard
    @IBOutlet weak var prefferedFit: UILabel!
   
    let alertVC = UIAlertController(title: "Enter Pants Waist Size", message: "", preferredStyle: .alert)
    override func viewDidLoad() {
        super.viewDidLoad()


        self.navigationItem.title = "BESPOKINO"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
 
        let casualGesture = UITapGestureRecognizer(target: self, action: #selector(casualAction))
        let slimGesture = UITapGestureRecognizer(target: self, action: #selector(slimAction))

        self.slimView.isHidden = true
        self.casualView.isHidden = true
        prefferedFit.isHidden = true
        
        pantWaistSize = defaults.string(forKey: "PANTWAISTSIZE")
        if pantWaistSize != nil{
            
            modelTextField.text = pantWaistSize
            topViewLength.constant = 0
            
            self.slimView.isHidden = false
            self.casualView.isHidden = false
            prefferedFit.isHidden = false
            
            self.casualView.addGestureRecognizer(casualGesture)
            self.slimView.addGestureRecognizer(slimGesture)
 
        }
        
        self.casualView.addGestureRecognizer(casualGesture)
        self.slimView.addGestureRecognizer(slimGesture)
    
        picker.delegate = self
        picker.dataSource = self
        
        modelTextField.inputView = picker
        let modelNo = defaults.string(forKey: "MODELNO")
        if modelNo != nil{
            print(modelNo!)
            self.casualLabel.text = "Your Bespokino Self-Measuring Tool Size is: \(modelNo!)".uppercased()
            self.slimLabel.text = "Your Bespokino Self-Measuring Tool Size is: \(Int(modelNo!)! - 1)".uppercased()
        }
        
        showAlert()

    }
    

    override func viewDidAppear(_ animated: Bool) {
   
        casualView.layer.borderWidth = 2
        casualView.layer.borderColor = #colorLiteral(red: 1, green: 0.8000000119, blue: 0.400000006, alpha: 1)
        
        slimView.layer.borderWidth = 2
        slimView.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
       
    
    
      
    }
    
    
    func showAlert()  {
        alertVC.addTextField { (textField) in
            textField.placeholder = "PANT WAIST SIZE"
            textField.inputView = self.picker
        }
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: {
            (alert) -> Void in
            
            let pantWaistSize = self.alertVC.textFields![0] as UITextField
            
            print("pantsize -- \(pantWaistSize.text!)")
        })
        alertVC.addAction(submitAction)
        alertVC.view.tintColor = UIColor.black
        present(alertVC, animated: true)
        
        
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
        self.defaults.set(Order.modelNo, forKey: "MODELNO")
        casualTick.image = UIImage(named: "tick")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ToolStatusViewController") as! ToolStatusViewController
        newViewController.modelNumber = String(Order.modelNo)
        self.navigationController?.pushViewController(newViewController, animated: true)
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
         self.defaults.set(Order.modelNo-1, forKey: "MODELNO")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ToolStatusViewController") as! ToolStatusViewController
        
        newViewController.modelNumber = String(Order.modelNo - 1)

        self.navigationController?.pushViewController(newViewController, animated: true)
    }


    @IBAction func measuringToolPresent(_ sender: Any) {
        
        
        if self.slim != 0 || self.fit != 0{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "MeasurmentParentViewController") as! MeasurmentParentViewController
            
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else if(self.modelNumber == "") {
            self.displayAlertMessage(messageToDisplay: "Choose Pant waist size")
        }else{
            
            self.displayAlertMessage(messageToDisplay: "please select your preffered fit")
        }
        
    }
    
    
    @IBAction func sendMeMeasuringTool(_ sender: Any) {
        
        
        if self.slim != 0 || self.fit != 0{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "PayTwentyViewController") as! PayTwentyViewController
            
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else if(self.modelNumber == "") {
            self.displayAlertMessage(messageToDisplay: "Choose Pant waist size")
        }
        else{
            
            self.displayAlertMessage(messageToDisplay: "please select your preffered fit")
       
        }

        
    }
    func displayAlertMessage(messageToDisplay: String)
    {
        let alertController = UIAlertController(title: "info", message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return model.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        
        return model[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        topViewLength.constant = 0
        let casualGesture = UITapGestureRecognizer(target: self, action: #selector(casualAction))
        let slimGesture = UITapGestureRecognizer(target: self, action: #selector(slimAction))
        
        self.slimView.isHidden = false
        self.casualView.isHidden = false
        prefferedFit.isHidden = false

        self.casualView.addGestureRecognizer(casualGesture)
        self.slimView.addGestureRecognizer(slimGesture)
        
        
        modelTextField.text = "PANTS WAIST SIZE: \(model[row])"
    
        
        alertVC.textFields![0].text = "PANTS WAIST SIZE: \(model[row])"
        
        self.view.endEditing(false)
        print(model[row])
        self.pantWaistSize = model[row]
        BodyPosture.pantWaistSize = model[row]
        
        
        defaults.set(model[row], forKey: "PANTWAISTSIZE")
        defaults.set(true,forKey:"YESPANT")
        Body.postBodyPosture { (result) in
            DispatchQueue.main.async {
                print(Order.modelNo)
                
                self.defaults.set(Order.modelNo, forKey: "MODELNO")
                self.casualLabel.text = "Your Bespokino Self-Measuring Tool Size is: \(Order.modelNo)"
                self.slimLabel.text = "Your Bespokino Self-Measuring Tool Size is: \(Order.modelNo-1)"

            }
       
        }
       // self.dismiss(animated: true, completion: nil)
    }

}
