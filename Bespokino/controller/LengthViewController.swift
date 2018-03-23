//
//  LengthViewController.swift
//  Bespokino
//
//  Created by Bespokino on 7/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SVProgressHUD
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
    
    var lengthImages = ["blue-line","green-line","yellow-line","red-line","Length_isgood","oneinch","twoinch"]
    let defaults = UserDefaults.standard

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
        let defaults =  UserDefaults.standard
        let modelNumber = defaults.string(forKey: "MODELNO")
        
        m.setMeasurment(m: modelNumber!) { (success, result, Error) in
            
            if success {
                
                let value  = result as Measurement!
                
                let lengthvalue:Double = (value?.lengthMaster)!
                let code  = Double(codeValue[indexPath.row])
                
                print(code + lengthvalue)
                
                defaults.set(lengthImages[indexPath.row], forKey: "LENGTH")

                SelectedValues.lengthMaster = code + lengthvalue
                
            }
            
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.layer.borderWidth = 2
        cell?.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @IBAction func continueButtonDidTap(_ sender: Any) {
        
        
        print("LENGTH")
        if SelectedValues.chestMaster == nil || SelectedValues.bicepsMaster == nil || SelectedValues.cuffMaster == nil || SelectedValues.shoulderMaster == nil || SelectedValues.neckMaster == nil || SelectedValues.waistMaster == nil || SelectedValues.hipsMaster == nil || SelectedValues.lengthMaster == nil || SelectedValues.sleeveMaster == nil {
        
            self.displayAlert(message: "Make sure that all values are selected")
        }else{
            
            defaults.set(true, forKey: "MEASURMENT")
            let checkInternet  = CheckInternetConnection()
            
            if checkInternet.isConnectedToNetwork(){
                SVProgressHUD.show()
                self.postMeasurment()
            }else {
                displayAlert(message: "Check your internet connection")
            }

        }
    
    }
    
    
    func postMeasurment() {
        
        let defaults = UserDefaults.standard
        let userid = defaults.string(forKey: "USERID")
        let modelNo = defaults.integer(forKey: "MODELNO")
        
      print(Order.userId)
        let parameters = """
        {"userID":"\(userid!)", "modelNo":"\(modelNo)", "Neck":"\(SelectedValues.neckMaster!)", "Cuff":"\(SelectedValues.cuffMaster!)", "Biceps":"\(SelectedValues.bicepsMaster!)",
                      "Sleeve":"\(SelectedValues.sleeveMaster!)", "Length":"\(SelectedValues.lengthMaster!)", "Shoulder":"\(SelectedValues.shoulderMaster!)", "Chest":"\(SelectedValues.chestMaster!)", "Waist":"\(SelectedValues.waistMaster!)",
        "Hips":"\(SelectedValues.hipsMaster!)", "SleeveAddup":"0.0", "LengthAddup":"0"}
    """

        print(parameters)
        var data: Data { return Data(parameters.utf8) }
        print(data)
        guard let url = URL(string: "http://www.bespokino.com/cfc/app2.cfc?wsdl&method=SaveCustomerMeasurements") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        
        do {
            
            request.httpBody = data
            
        }
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    
                    SVProgressHUD.dismiss()
                    
                    
                    guard let response = json as? [String:Any] else{return}
                    guard let userid = response["UserId"] as? Int else {return}
                    guard let modelNo = response["modelNo"] as? Int else {return}
                    
                    guard let err = response["Error"] as? Bool else {return}

                    if (!err)
                    {
                        
                        DispatchQueue.main.async {
                            
                            if Order.cartCount > 0 {
                                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let newViewController = storyBoard.instantiateViewController(withIdentifier: "InvoiceViewController") as! InvoiceViewController
                                
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }else{
                                self.displayAlert(message: "YOUR CART IS EMPTY")
                            }
                        
                          
                        }

                    }
                    
                    Order.userId = userid
                    Order.modelNo = modelNo
                    
                    
                } catch {
                    print(error)
                }
            }
            
            }.resume()
        
    }
    
    func displayAlert(message:String)  {
        let alertController = UIAlertController(title: "info", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        
        let okAction  = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}
