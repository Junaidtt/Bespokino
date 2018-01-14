//
//  BicepsViewController.swift
//  Bespokino
//
//  Created by Bespokino on 7/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class BicepsViewController: UIViewController,IndicatorInfoProvider,UITableViewDelegate,UITableViewDataSource {
  
    let m = MeasurementValue()
    var codeValue = [0,-0.5,-1.0,-1.5]
    var biceps:[UIImage] = [
        UIImage(named: "hook")!,
        UIImage(named: "red")!,
        UIImage(named: "yellow")!,
         UIImage(named: "green")!
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        
    
    
    
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return biceps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "biceps", for: indexPath) as! BicepsTableViewCell
        
        cell.bicepsImage.image = biceps[indexPath.row]
        cell.layer.borderWidth = 2
        cell.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return cell
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "BICEPS")
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.layer.borderWidth = 2
        cell?.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        
        m.setMeasurment(m: "2") { (success, result, Error) in
            
            if success {
                
                let value  = result as Measurement!
                
                let bicepsvalue:Double = (value?.bicepsMaster)!
                let code  = Double(codeValue[indexPath.row])
                
                print(code + bicepsvalue)
                
                SelectedValues.bicepsMaster = code + bicepsvalue
            }
            
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.layer.borderWidth = 2
        cell?.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}
