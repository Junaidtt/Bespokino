//
//  InnerContrastViewController.swift
//  Bespokino
//
//  Created by Bespokino on 4/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class InnerContrastViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var saveButton: UIButton!
    
    var inner = ["INNER COLLAR","INNER CUFF","INNER PLACKET","SLEEVE VENTE"]
    var img:[UIImage] = [
        UIImage(named: "inner_c")!,
        UIImage(named: "inner_cuff")!,
        UIImage(named: "inner_placket")!,
        UIImage(named: "sleeve_vent")!
    ]
    
    @IBOutlet weak var innerContrastTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        self.navigationItem.title = "BESPOKINO"
        saveButton.layer.cornerRadius = 6
        self.innerContrastTableView.allowsMultipleSelection = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inner.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inner", for: indexPath) as! InnerContrastTableViewCell
        
        cell.innerContrastLabel.text = inner[indexPath.row]
        cell.innerContrastImage.image = img[indexPath.row]
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = backgroundView
        cell.marker.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell1 = tableView.cellForRow(at: indexPath)
      
        cell1?.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        cell1?.layer.borderWidth = 2
        
        
        let cell:InnerContrastTableViewCell = tableView.cellForRow(at: indexPath) as! InnerContrastTableViewCell
        
        cell.marker.isHidden = false

        
        if cell.innerContrastLabel.text == "INNER COLLAR"{
            
            StylingTask.collarContrastFabric = "547"
               AdditionalOptions.collarContrastFabric = "547"
            
        }else if cell.innerContrastLabel.text == "INNER CUFF" {
            
            StylingTask.cuffContrastFabric = "549"
              AdditionalOptions.cuffContrastFabric = "549"
            
        }else if cell.innerContrastLabel.text ==  "INNER PLACKET"{
            
            StylingTask.placketContrastFabric = "150"
               AdditionalOptions.placketContrastFabric = "150"
            
        }else if cell.innerContrastLabel.text == "SLEEVE VENTE"{
            
            StylingTask.sleeveVentContrastFabric = "148"
               AdditionalOptions.sleeveVentContrastFabric = "148"
        }
        
        
        
    }

  
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell1 = tableView.cellForRow(at: indexPath)
        
        cell1?.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "inner", for: indexPath) as! InnerContrastTableViewCell

        cell.marker.isHidden = true

        
        if cell.innerContrastLabel.text == "INNER COLLAR"{
            
            StylingTask.collarContrastFabric = ""
            
        }else if cell.innerContrastLabel.text == "INNER CUFF" {
            
            StylingTask.cuffContrastFabric = ""
            
        }else if cell.innerContrastLabel.text ==  "INNER PLACKET"{
            
            StylingTask.placketContrastFabric = ""
            
        }else if cell.innerContrastLabel.text == "SLEEVE VENTE"{
            
            StylingTask.sleeveVentContrastFabric = ""
        }
        
    }
    
    @IBAction func saveButtonDidTap(_ sender: Any) {
        
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)

        
    }
 
    
    
    
}
