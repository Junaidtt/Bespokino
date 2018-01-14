//
//  CuffMeasurmentViewController.swift
//  Bespokino
//
//  Created by Bespokino on 7/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class CuffMeasurmentViewController: UIViewController,IndicatorInfoProvider,UITableViewDataSource,UITableViewDelegate {

    
    let m = MeasurementValue()
    var codeValue = [0,-1,-2,-3,-4,-5,-6,-7,-8,-9]
    var cuff:[UIImage] = [
        UIImage(named: "cuff1")!,
        UIImage(named: "cuff2")!,
        UIImage(named: "cuff3")!,
        UIImage(named: "cuff3")!,
        UIImage(named: "cuff5")!,
        UIImage(named: "cuff6")!,
        UIImage(named: "cuff6")!,
        UIImage(named: "cuff7")!,
        UIImage(named: "cuff8")!,
        UIImage(named: "cuff9")!
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cuff.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cuff", for: indexPath) as! CuffMeasureTableViewCell
        
        
        cell.cuffPoints.image = cuff[indexPath.row]
        
        cell.layer.borderWidth = 2
        cell.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return cell
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "CUFF")
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.layer.borderWidth = 2
        cell?.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        
        m.setMeasurment(m: "2") { (success, result, Error) in
            
            if success {
                
                let value  = result as Measurement!
                
                let cuffvalue:Double = (value?.cuffMaster)!
                let code  = Double(codeValue[indexPath.row])
                
                print(code+cuffvalue)
                SelectedValues.cuffMaster = code + cuffvalue
            }
            
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.layer.borderWidth = 2
        cell?.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
