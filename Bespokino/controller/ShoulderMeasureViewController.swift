//
//  FirstViewController.swift
//  Bespokino
//
//  Created by Bespokino on 6/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ShoulderMeasureViewController: UIViewController,IndicatorInfoProvider,UITableViewDelegate,UITableViewDataSource ,UIPickerViewDataSource,UIPickerViewDelegate{
    
    let defaults = UserDefaults.standard



    let m = MeasurementValue()
       var codeValue = [0,-1,-2]
    var shoulder:[UIImage] = [
        UIImage(named: "hook")!,
        UIImage(named: "red")!,
        UIImage(named: "yellow")!,
    ]
    
    var shoulderImage = ["hook","red","yellow"]
    
    @IBOutlet weak var topViewLength: NSLayoutConstraint!
    
    var modelNumber:String?
    var model =  ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","1L","2L","3L","4L","5L","6L","7L","8L","9L","10L","11L","12L","13L","14L"]
    

    let picker = UIPickerView()
    
    @IBOutlet weak var modelTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)

        modelNumber = defaults.string(forKey: "MODELNO")
        picker.delegate = self
        picker.dataSource = self
        modelTextField.inputView = picker
        if  modelNumber != nil{
            modelTextField.text = modelNumber!

        }
    }

  
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "SHOULDER")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return shoulder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoulder", for: indexPath) as! ShulderTableViewCell
        
        cell.shoulderPoints.image = shoulder[indexPath.row]
        
        cell.layer.borderWidth = 2
        cell.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.layer.borderWidth = 2
        cell?.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        if(self.modelNumber != nil){
            
            m.setMeasurment(m: self.modelNumber! ) { (success, result, Error) in
              print("asdasd")
                if success {
                    
                    let value  = result as Measurement!
                    
                    let shouldervalue:Double = (value?.shoulderMaster)!
                    let code  = Double(codeValue[indexPath.row])
                    
                    print(code + shouldervalue)
                    print(shoulder[indexPath.row])
                    

                    defaults.set(shoulderImage[indexPath.row], forKey: "SHOULDER")
                    
                    SelectedValues.shoulderMaster = code + shouldervalue
                    
                    print(SelectedValues.shoulderMaster!)
                }
            }
        }
       
  
        Control.pointer = 1
        let center = storyboard?.instantiateViewController(withIdentifier: "MeasurmentParentViewController") as? MeasurmentParentViewController
       // center?.moveToViewcontroller(at: 1)
        center?.moveToViewControllerAtIndex(1)

      
        
       
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.layer.borderWidth = 2
        cell?.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
    }
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return model.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return model[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        modelTextField.text = model[row]
        self.view.endEditing(false)
        print(model[row])
        modelNumber = model[row]
        print(modelNumber!)
        self.defaults.set(modelNumber, forKey: "MODELNO")

        
    }

}
