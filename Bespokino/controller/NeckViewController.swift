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
  
    @IBOutlet weak var shirtImage: UIImageView!
    let m = MeasurementValue()
    
    var codeValue9 = [-10,-9,-8,-7,-6,-5,-4,-3,-2,-1,0]
    var codeValue1 = [-9,-8,-7,-6,-5,-4,-3,-2,-1,0]
    var codeValue = [Int]()

    @IBOutlet weak var neckTB: UITableView!
    

    var neck9:[UIImage] = [UIImage(named:"collar11")!,
                           UIImage(named: "collar10")!,
                           UIImage(named: "collar9")!,
                           UIImage(named: "collar8")!,
                           UIImage(named: "collar7")!,
                           UIImage(named: "collar6")!,
                           UIImage(named: "collar5")!,
                           UIImage(named: "collar4")!,
                           UIImage(named: "collar3")!,
                           UIImage(named: "collar2")!,
                           UIImage(named: "collar1")!]
    
    
    var neck1:[UIImage] = [
        UIImage(named: "neck10")!,
        UIImage(named: "neck9")!,
        UIImage(named: "neck8")!,
        UIImage(named: "neck7")!,
        UIImage(named: "neck6")!,
        UIImage(named: "neck5")!,
        UIImage(named: "neck4")!,
        UIImage(named: "neck3")!,
        UIImage(named: "neck2")!,
        UIImage(named: "neck1")!
    ]
    
    var neck:[UIImage] = [UIImage]()
  var neckImages = [String]()
  var neckImages9 = ["collar1","collar2","collar3","collar4","collar5","collar6","collar7","collar8","collar9","collar10","collar11"]
    var neckImages1 = ["neck1","neck2","neck3","neck4","neck5","neck6","neck7","neck8","neck9","neck10,"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        let modelNo = defaults.string(forKey: "MODELNO")
        neckImages.removeAll()
        print(Int(modelNo!)!)
        if (Int(modelNo!)! > 8){
            neck = neck9
            codeValue = codeValue9
            neckImages = neckImages9
            neckTB.reloadData()
            self.shirtImage.image = UIImage(named:"neck_guide9")
            
        }else if (Int(modelNo!)! < 9){
            neck = neck1
            codeValue = codeValue1
            neckImages = neckImages1
            neckTB.reloadData()
            self.shirtImage.image = UIImage(named:"neck_guide8")
        }
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        neckImages.removeAll()
        let modelNo = defaults.string(forKey: "MODELNO")
        
        print(Int(modelNo!)!)
        if (Int(modelNo!)! > 8){
            neck = neck9
            codeValue = codeValue9
            neckImages = neckImages9
            neckTB.reloadData()
            self.shirtImage.image = UIImage(named:"neck_guide9")
            
        }else if (Int(modelNo!)! < 9){
            neck = neck1
            codeValue = codeValue1
            neckImages = neckImages1
            neckTB.reloadData()
            self.shirtImage.image = UIImage(named:"neck_guide8")
        }

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
        
         let modelNo = defaults.string(forKey: "MODELNO")
        m.setMeasurment(m: modelNo!) { (success, result, Error) in
            
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
