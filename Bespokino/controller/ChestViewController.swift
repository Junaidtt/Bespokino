//
//  ChestViewController.swift
//  Bespokino
//
//  Created by Bespokino on 7/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class ChestViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,IndicatorInfoProvider {
    
    let m = MeasurementValue()
    var codeValue = [0,-1,-2,-3,-4]
    var chest:[UIImage] = [
        UIImage(named: "hook")!,
        UIImage(named: "red")!,
        UIImage(named: "yellow")!,
        UIImage(named: "green")!,
        UIImage(named: "blue")!

        ]
    var chestImages = ["hook","red","yellow","green","blue"]
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "chest", for: indexPath) as! ChestTableViewCell
        
        cell.chestPoints.image = chest[indexPath.row]
        
        cell.layer.borderWidth = 2
        cell.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return cell
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "CHEST")
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.layer.borderWidth = 2
        cell?.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        
        m.setMeasurment(m: "2") { (success, result, Error) in
            
            if success {
                
                let value  = result as Measurement!
                
                let chestvalue:Double = (value?.chestMaster)!
                let code  = Double(codeValue[indexPath.row])
                
                print(code+chestvalue)
                defaults.set(chestImages[indexPath.row], forKey: "CHEST")

                SelectedValues.chestMaster = code + chestvalue
                
            }
            
        }
        
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.layer.borderWidth = 2
        cell?.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
}
