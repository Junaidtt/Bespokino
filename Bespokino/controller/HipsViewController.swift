//
//  HipsViewController.swift
//  Bespokino
//
//  Created by Bespokino on 7/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class HipsViewController: UIViewController,IndicatorInfoProvider,UITableViewDelegate,UITableViewDataSource {

    let m = MeasurementValue()
    var codeValue = [0,-1,-2,-3,-4]
    var hips:[UIImage] = [
        UIImage(named: "hook")!,
        UIImage(named: "red")!,
        UIImage(named: "yellow")!,
        UIImage(named: "green")!,
        UIImage(named: "blue")!
        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "HIPS")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hips", for: indexPath) as! HipsTableViewCell
        
        cell.hipsPoints.image = hips[indexPath.row]
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
                
                let hipsvalue = value?.hipsMaster
                let code  = Double(codeValue[indexPath.row])
                
                print(code+hipsvalue!)
                
            }
            
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.layer.borderWidth = 2
        cell?.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }

}
