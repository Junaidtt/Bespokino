//
//  FirstViewController.swift
//  Bespokino
//
//  Created by Bespokino on 6/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ShoulderMeasureViewController: UIViewController,IndicatorInfoProvider,UITableViewDelegate,UITableViewDataSource {


    let m = MeasurementValue()
       var codeValue = [0,-1,-2]
    var shoulder:[UIImage] = [
        UIImage(named: "hook")!,
        UIImage(named: "red")!,
        UIImage(named: "yellow")!,
    ]
 
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        
        m.setMeasurment(m: "2") { (success, result, Error) in
            
            if success {
                
                let value  = result as Measurement!
                
                let shouldervalue:Double = (value?.shoulderMaster)!
                let code  = Double(codeValue[indexPath.row])
                
                print(code + shouldervalue)
                
                SelectedValues.shoulderMaster = code + shouldervalue
                
                print(SelectedValues.shoulderMaster!)
            }
        }
        //UserDefaults.standard.set(1, forKey: "check")
        Control.pointer = 1
        let center = storyboard?.instantiateViewController(withIdentifier: "MeasurmentParentViewController") as? MeasurmentParentViewController
       // center?.moveToViewcontroller(at: 1)
        center?.moveToViewControllerAtIndex(1)
        
        //self.navigationController?.pushViewController(center!, animated: true)

      //  self.present(center!, animated: true, completion: nil)
      
        
       
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.layer.borderWidth = 2
        cell?.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
        
    
}
