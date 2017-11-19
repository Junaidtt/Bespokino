//
//  StylingTask.swift
//  Bespokino
//
//  Created by Bespokino on 11/20/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import Foundation

class StylingTask: NSObject {

    var itemname:String?
    var itemImage:UIImage?
    var optionvalue:Int?
    
    init(name:String,image:UIImage,optionVal:Int) {
        
        self.itemname = name
        self.itemImage = image
        self.optionvalue = optionVal
        
    }
    override init() {
        
    }
    func getCollarData(completion:([StylingTask])->Void)  {
        
         var item = [StylingTask]()
        
        let collar1 = StylingTask(name: "NORMAL", image: UIImage(named: "Collar_a")!, optionVal: 191)
        let collar2 = StylingTask(name: "WIDE SPREAD", image: UIImage(named: "Collar_b")!, optionVal: 192)
        let collar3 = StylingTask(name: "ROUND EDGE", image: UIImage(named: "Collar_c")!, optionVal: 193)
        let collar4 = StylingTask(name: "BUTTON DOWN", image: UIImage(named: "Collar_d")!, optionVal: 194)
        let collar5 = StylingTask(name: "MANDARIN", image: UIImage(named: "Collar_e")!, optionVal: 195)
        
        item.append(collar1)
        item.append(collar2)
        item.append(collar3)
        item.append(collar4)
        item.append(collar5)
        
        completion(item)
        
        
    }
    
    
    
    func getCuffData(completion:([StylingTask]) -> Void) {
        
        
        var item = [StylingTask]()
        
        let cuff1 = StylingTask(name: "1 BUTTON SQUARE", image:UIImage(named: "button1square")!, optionVal: 200)
        let cuff2 = StylingTask(name: "1 BUTTON CURVEDD", image:UIImage(named: "button1curved")!, optionVal: 201)
        let cuff3 = StylingTask(name: "1 BUTTON ANGLED", image:UIImage(named: "button1angled")!, optionVal: 531)
      
        let cuff4 = StylingTask(name: "2 BUTTONS SQUARE", image:UIImage(named: "button2squared")!, optionVal: 202)
        let cuff5 = StylingTask(name: "2 BUTTONS CURVED", image:UIImage(named: "buttons2curved")!, optionVal: 532)
        let cuff6 = StylingTask(name: "2 BUTTONS ANGLE", image:UIImage(named: "buttons2angled")!, optionVal: 203)
        
        let cuff7 = StylingTask(name: "FRENCH SQUARED", image:UIImage(named: "frenchsquared")!, optionVal: 533)
        let cuff8 = StylingTask(name: "FRENCH CURVED", image:UIImage(named: "frenchcurved")!, optionVal: 359)
        let cuff9 = StylingTask(name: "FRENCH ANGLED", image:UIImage(named: "frenchangled")!, optionVal: 358)
        
        
        
        item.append(cuff1)
        item.append(cuff2)
        item.append(cuff3)
        item.append(cuff4)
        item.append(cuff5)
        item.append(cuff6)
        item.append(cuff7)
        item.append(cuff8)
        item.append(cuff9)

        completion(item)
        
        
    }
    
    func cuffInsertionTask(completion:@escaping (Bool,Any?,Error?) -> Void) {
        
        DispatchQueue.global().async {
            
            
            let parameters = ["orderNo": "@0", "customerID": "0","paperNo": "0", "trackingID": "0","optionValue":"201"]
            guard let url = URL(string: "http://www.bespokino.com/cfc/app.cfc?wsdl&method=insertCuffStylingInfo") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
            request.httpBody = httpBody
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        DispatchQueue.main.async {
                            completion(true,json,nil)
                            
                        }
                        
                    } catch {
                        print(error)
                        
                        DispatchQueue.main.async {
                            completion(false,nil,error)
                            
                        }
                    }
                }
                
                }.resume()
        }
        
        
    }
    
    
    
    
    
    func collarInsertionTask(completion:@escaping (Bool,Any?,Error?) -> Void) {
        
        DispatchQueue.global().async {
            
            
            let parameters = ["orderNo": "@0", "customerID": "0","paperNo": "0", "trackingID": "0","optionValue":"191"]
            guard let url = URL(string: "http://www.bespokino.com/cfc/app.cfc?wsdl&method=insertCollarStylingInfo") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
            request.httpBody = httpBody
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
            if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                      
                        DispatchQueue.main.async {
                            completion(true,json,nil)

                        }
                        
                    } catch {
                        print(error)
                        
                        DispatchQueue.main.async {
                            completion(false,nil,error)
                            
                        }
                     
                        
                    }
                }
                
                }.resume()
        }
        
    }
    
    
}








