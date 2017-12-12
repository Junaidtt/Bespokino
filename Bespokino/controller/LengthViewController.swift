//
//  LengthViewController.swift
//  Bespokino
//
//  Created by Bespokino on 7/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class LengthViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,IndicatorInfoProvider {

    let m = MeasurementValue()
    var codeValue = [-4,-3,-2,-1,0,1,2]
     var length:[UIImage] = [
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

        // Do any additional setup after loading the view.
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "LENGTH")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return length.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell =  tableView.dequeueReusableCell(withIdentifier: "length", for: indexPath) as! LengthTableViewCell
        
        cell.lengthpoint.image = length[indexPath.row]
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
                
                let lengthvalue = value?.lengthMaster
                let code  = Double(codeValue[indexPath.row])
                
                print(code+lengthvalue!)
                
            }
            
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.layer.borderWidth = 2
        cell?.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @IBAction func continueButtonDidTap(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "InvoiceViewController") as! InvoiceViewController
        
        self.navigationController?.pushViewController(newViewController, animated: true)
        
        
        
    }
    
}
