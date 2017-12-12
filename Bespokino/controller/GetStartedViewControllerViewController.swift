//
//  GetStartedViewControllerViewController.swift
//  Bespokino
//
//  Created by Bespokino on 8/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import CoreData
class GetStartedViewControllerViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var bespokinoShirtLabel: UILabel!
    @IBOutlet weak var grayContainerView: UIView!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var modelTextField: UITextField!
   var modelNumber:String?
   var model = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","1L","2L","3L","4L","5L","6L","7L","8L","9L","10L","11L","12L","13L","14L"]
    
    let picker = UIPickerView()
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationItem.title = "BESPOKINO"
      
        grayContainerView.layer.cornerRadius = 3.0
        grayContainerView.layer.masksToBounds = true
        
        modelTextField.layer.cornerRadius = 3.0
        modelTextField.layer.masksToBounds = true
        
        
        getStartedButton.layer.cornerRadius = 3.0
        getStartedButton.layer.masksToBounds = true
        
        picker.delegate = self
        picker.dataSource = self
        
        modelTextField.inputView = picker
        
        
    }
 @IBAction func getStartButtonDidTap(_ sender: Any) {
    
     self.modelNumber = modelTextField.text!
    
//    let  newModel = NSEntityDescription.insertNewObject(forEntityName: "Model", into: context)
//        newModel.setValue(Double(self.modelNumber!), forKey: "modelNumber")
//    do{
//        try context.save()
//    }catch{
//        print(error)
//    }
//
    
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
        
    }

  
    
}
