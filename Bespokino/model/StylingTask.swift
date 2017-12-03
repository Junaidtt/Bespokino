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
    
    /*
     {"orderNo":"9120239","customerID":"1949","paperNo":"50460",
     "trackingID":"9120239 - 1949 - 1", "placket":"160",
     "backPleats":"158", "pocket":"188", "shortSleeve":"209",
     "tuxedo":"528", "tuxedoPleat":"530", "collarContrastFabric":"549",
     "cuffContrastFabric":"548", "placketContrastFabric":"151",
     "sleeveVentContrastFabric":"149", "whiteCuffAndCollar":"207",
     "contrastFabricCategory":"inner_collar", "contrastFabricID":"65",
     "buttonholeColor":"", "btnType":"Save"}
     */
    static var pocket = ""
    static var placket = ""
    static var backpleats = ""
    static var shortSleeve = ""
    static var tuxedo = ""
    static var tuxedoPleat = ""
    static var collarContrastFabric = ""
    static var cuffContrastFabric = ""
    static var placketContrastFabric = ""
    static var sleeveVentContrastFabric = ""
    static var whiteCuffAndCollar = ""
    static var contrastFabricCategory = "inner_collar"
    static var contrastFabricID = ""
    static var buttonholeColor = ""
    static var btnType = ""
    
    
    
    
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
    
    func getAddOptiondata(completion:([StylingTask]) -> Void) {
        
        var item = [StylingTask]()

        let addOptiom1 = StylingTask(name: "POCKET", image: UIImage(named: "pocket")!, optionVal: 187)
        let addOptiom2 = StylingTask(name: "TUXEDO", image: UIImage(named: "tuxedo_pleats")!, optionVal: 528)
        let addOptiom3 = StylingTask(name: "CONTRAST", image: UIImage(named: "contrast_new")!, optionVal: 547)
        let addOptiom4 = StylingTask(name: "BUTTON HOLE & THREAD", image: UIImage(named: "thread")!, optionVal: 547)
        let addOptiom5 = StylingTask(name: "WHITE COLLAR & CUFF", image: UIImage(named: "whitec")!, optionVal: 206)
        let addOptiom6 = StylingTask(name: "PLACKET", image: UIImage(named: "placketb")!, optionVal: 159)
        let addOptiom7 = StylingTask(name: "PLEAT", image: UIImage(named: "twopleats")!, optionVal: 156)
        let addOptiom8 = StylingTask(name: "SHORT", image:UIImage(named: "short_sleev")!, optionVal: 208)
        
        
        
        item.append(addOptiom1)
        item.append(addOptiom2)
        
        item.append(addOptiom3)
        
        item.append(addOptiom4)
        item.append(addOptiom5)
        item.append(addOptiom6)
        item.append(addOptiom7)
        item.append(addOptiom8)

        
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








