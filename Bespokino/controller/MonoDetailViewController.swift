//
//  MonoDetailViewController.swift
//  Bespokino
//
//  Created by Bespokino on 26/1/2561 BE.
//  Copyright © 2561 bespokinoapp. All rights reserved.
//

import UIKit

class MonoDetailViewController: UIViewController {

    @IBOutlet weak var mPosition: UILabel!
    @IBOutlet weak var mStyle: UILabel!
    @IBOutlet weak var mText: UILabel!
    var trackid = ""
    override func viewDidLoad() {
        super.viewDidLoad()

    print(trackid)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        self.navigationItem.title = "BESPOKINO"
        getMonoDetails()

   }
    
    func getMonoDetails() {
        
        print(self.trackid)
        let defaults = UserDefaults.standard
      //  let currentTrackingID = defaults.string(forKey: "TRACKINGID")
        let currentOrderNo = defaults.integer(forKey: "ORDERNO")
        let currentCustomerID = defaults.integer(forKey: "CUSTOMERID")
        let currentpaperNo = defaults.integer(forKey: "PAPERNO")
        guard let url = URL(string: "http://www.bespokino.com/cfc/app2.cfc?wsdl&method=getOrderMonogramValue&customerID=\(currentCustomerID)&orderNo=\(currentOrderNo)&paperNo=\(currentpaperNo)&trackingID="+self.trackid) else { return }
        print(url)
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                print(data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                   
                    print(json)
                    
                    guard let jsonDic = json as? [String:Any] else {return}
                    
                    guard let text  = jsonDic["monogramText"] as? String else {return}
                    
                    guard let style = jsonDic["monogramStyle"] as? String else {return}
                    
                    guard let position = jsonDic["monogramPosition"] as? Double else {return}
                    
                    
                    
                    DispatchQueue.main.async {
                        self.mText.text = "Monogram text : \(text)"
                          self.mStyle.text = "Monogram style :"+style
                      
                        
//                        if style == 167{
//                              self.mStyle.text = "Monogram style :"+"Simple"
//                        }else if style == 168
//                        {
//                               self.mStyle.text = "Monogram style : "+"Script"
//                        }else if style == 169{
//                               self.mStyle.text = "Monogram style :  "+"Fancy"
//                        }
                        //self.mPosition.text = "Monogram position : \(position)"
                        
                        if position == 170{
                                 self.mPosition.text = "Monogram position : "+"On the Body"
                        }
                        else if position == 171{
                              self.mPosition.text = "Monogram position : "+"On the Cuff"
                        }else if position == 172{
                                self.mPosition.text = "Monogram position : "+"On the Pocket"
                        }else if position == 174{
                                self.mPosition.text = "Monogram position : "+"back of the collar"
                        }else if position == 173{
                            self.mPosition.text = "Monogram position : "+"back of the collar"

                        }
    
                    }
                    
                } catch {
                    print(error)
                }
                
            }
            }.resume()
        
    }
    


}
