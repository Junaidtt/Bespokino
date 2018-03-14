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

    @IBOutlet weak var cuffTB: UITableView!
    @IBOutlet weak var shirtImage: UIImageView!
    
    let m = MeasurementValue()
    var codeValue = [0,-1,-2,-3,-4,-5,-6,-7,-8,-9]
    var cuff9:[UIImage] = [
        UIImage(named: "cuff9_1")!,
        UIImage(named: "cuff9_2")!,
        UIImage(named: "cuff9_3")!,
        UIImage(named: "cuff9_4")!,
        UIImage(named: "cuff9_5")!,
        UIImage(named: "cuff9_6")!,
        UIImage(named: "cuff9_7")!,
        UIImage(named: "cuff9_8")!,
        UIImage(named: "cuff9_9")!,
 
    ]
    var cuff1:[UIImage] = [
        UIImage(named: "cuff8_1")!,
        UIImage(named: "cuff8_2")!,
        UIImage(named: "cuff8_3")!,
        UIImage(named: "cuff8_4")!,
        UIImage(named: "cuff8_5")!,
        UIImage(named: "cuff8_6")!,
        UIImage(named: "cuff8_7")!,
        UIImage(named: "cuff8_8")!,
        UIImage(named: "cuff8_9")!,
        
        ]
    var cuff:[UIImage] = [UIImage]()
    
    
    
    
    var cuffImages9 = ["cuff9_1","cuff9_2","cuff9_3","cuff9_4","cuff9_5","cuff9_6","cuff9_7","cuff9_8","cuff8_9"]
    var cuffImages8 = ["cuff8_1","cuff8_2","cuff8_3","cuff8_4","cuff8_5","cuff8_6","cuff8_7","cuff8_8","cuff8_9"]
    var cuffImages = [String]()
    
    
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let modelNo = defaults.string(forKey: "MODELNO")
        cuff.removeAll()
        cuffImages.removeAll()
        print(Int(modelNo!)!)
        if (Int(modelNo!)! > 8){
            cuff = cuff9
            
            self.shirtImage.image = UIImage(named:"cuff_guide9")
            cuffImages = cuffImages9
            cuffTB.reloadData()
            
        }else if (Int(modelNo!)! < 9){
            
             cuff = cuff1
              cuffImages = cuffImages8
             self.shirtImage.image = UIImage(named:"cuff_guide8")
            cuffTB.reloadData()

        }

        self.cuffTB.reloadData()
   
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let modelNo = defaults.string(forKey: "MODELNO")
          cuff.removeAll()
        cuffImages.removeAll()
        print(Int(modelNo!)!)
        if (Int(modelNo!)! > 8){
            cuff.removeAll()
             cuff = cuff9
                cuffImages = cuffImages9
            self.shirtImage.image = UIImage(named:"cuff_guide9")
            
        }else if (Int(modelNo!)! < 9){
              cuff = cuff1
            cuffImages = cuffImages8
            self.shirtImage.image = UIImage(named:"cuff_guide8")
        }
        self.cuffTB.reloadData()
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
                
                defaults.set(cuffImages[indexPath.row], forKey: "CUFF")

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
