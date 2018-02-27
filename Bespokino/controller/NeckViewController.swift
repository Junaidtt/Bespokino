//
//  NeckViewController.swift
//  Bespokino
//
//  Created by Bespokino on 7/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class NeckViewController: UIViewController,IndicatorInfoProvider,UITableViewDataSource,UITableViewDelegate {
  
    let m = MeasurementValue()
    var codeValue = [0,-1,-2,-3,-4,-5,-6,-7,-8,-9]
    var neck:[UIImage] = [
        UIImage(named: "neck1")!,
        UIImage(named: "neck2")!,
        UIImage(named: "neck3")!,
        UIImage(named: "neck4")!,
        UIImage(named: "neck5")!,
        UIImage(named: "neck6")!,
        UIImage(named: "neck7")!,
        UIImage(named: "neck8")!,
        UIImage(named: "neck9")!,
        UIImage(named: "neck10")!
    ]
    
    var neckImages = ["neck1","neck2","neck3","neck4","neck5","neck6","neck7","neck8","neck9","neck10"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return neck.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "neck", for: indexPath) as! NeckTableViewCell
        
        cell.neckPoints.image = neck[indexPath.row]

        cell.layer.borderWidth = 2
        cell.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return cell
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "COLLAR")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.layer.borderWidth = 2
        cell?.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        
        
        m.setMeasurment(m: "2") { (success, result, Error) in
            
            if success {
                
                let value  = result as Measurement!
                
                let neckvalue:Double = (value?.neckMaster)!
                let code  = Double(codeValue[indexPath.row])
                
                print(code+neckvalue)
                
                defaults.set(neckImages[indexPath.row], forKey: "NECK")

                SelectedValues.neckMaster = code + neckvalue
                
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
