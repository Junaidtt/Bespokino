//
//  SecondViewController.swift
//  Bespokino
//
//  Created by Bespokino on 6/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class SleeveViewController: UIViewController,IndicatorInfoProvider,UITableViewDataSource,UITableViewDelegate {
   
    let m = MeasurementValue()
    var codeValue = [-4,-3,-2,-1,0,1,2]
    var sleeve:[UIImage] = [
        UIImage(named: "blue-line")!,
        UIImage(named: "green-line")!,
        UIImage(named: "yellow-line")!,
        UIImage(named: "red-line")!,
        UIImage(named: "Length_isgood")!,
        UIImage(named: "oneinch")!,
        UIImage(named: "twoinch")!,
        ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
    
    }

   
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "SLEEVE")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sleeve.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "sleeve", for: indexPath) as! SleeveTableViewCell
        
        cell.sleevePoints.image = sleeve[indexPath.row]
        cell.layer.borderWidth = 2
        cell.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.layer.borderWidth = 2
        cell?.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        
        m.setMeasurment(m: "2") { (success, result, Error) in
            
            if success {
                
                let value  = result as Measurement!
                
                let sleevevalue:Double = (value?.sleeveMaster)!
                let code  = Double(codeValue[indexPath.row])
                
                print(code + sleevevalue)
                SelectedValues.sleeveMaster = code + sleevevalue
            }
            
        }
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.layer.borderWidth = 2
        cell?.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    

}
