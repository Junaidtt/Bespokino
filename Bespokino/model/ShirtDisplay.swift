//
//  ShirtDisplay.swift
//  Bespokino
//
//  Created by Bespokino on 11/19/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import Foundation
import CoreData

class ShirtDisplay {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    

    func getCustomerDetailsTask(completion:@escaping (Bool,Any?,Error?) -> Void ) {
        
        StylingTask.pocket = ""
        StylingTask.placket = ""
        StylingTask.backpleats = ""
        StylingTask.shortSleeve = ""
        StylingTask.tuxedo = ""
        StylingTask.tuxedoPleat = ""
        StylingTask.collarContrastFabric = ""
        StylingTask.cuffContrastFabric = ""
        StylingTask.placketContrastFabric = ""
        StylingTask.sleeveVentContrastFabric = ""
        StylingTask.whiteCuffAndCollar = ""
        StylingTask.contrastFabricCategory = "inner_collar"
        StylingTask.contrastFabricID = ""
        StylingTask.buttonholeColor = ""
        StylingTask.btnType = ""
        
        

        DispatchQueue.global().async() {
            
 
            let parameters = ["orderNo": "\(Order.orderNo)", "customerID": "\(Order.customerID)","paperNo": "\(Order.paperNo)", "trackingID": Order.trackingID,"fabricID":Order.fabid]
            
            print(parameters)
            
            
            guard let url = URL(string: "http://www.bespokino.com/cfc/app.cfc?wsdl&method=insertOrderFabricInfo") else { return }
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
                        print(json)

                        guard let result = json as? [String:Any] else {return}
                        
                        guard let err = result["Error"] as? Bool else {return}
                   
                        if (!err){
                          
                            guard let customerID = result["customerID"] as? Int else {return}

                            guard let orderNO = result["orderNo"] as? Int else {return}
                            
                            guard let paperNO = result["paperNo"] as? Int else{return}
                            
                            guard let trackingID = result["trackingID"] as? String else {return}
                            print(trackingID)
                            
                            self.shirtItemCode(customerid: customerID, orderno: orderNO, paperno: paperNO, trackingid: trackingID)
                            
                            Order.customerID = customerID
                            Order.orderNo = orderNO
                            Order.paperNo = paperNO
                            Order.trackingID = trackingID
                            
                            let defaults = UserDefaults.standard
                            defaults.set(customerID, forKey: "CUSTOMERID")
                            defaults.set(orderNO, forKey: "ORDERNO")
                            defaults.set(paperNO, forKey: "PAPERNO")
                            defaults.set(trackingID, forKey: "TRACKINGID")
                            
                            defaults.synchronize()

                        }
    
                        print(err)

                        DispatchQueue.main.async {
                            
                        completion(true, json, nil)
                            
                        }
                   } catch {
                        print(error)
                        DispatchQueue.main.async {
                            
                            completion(false, nil, error)
                            
                        }

                    }
                }
           }.resume()
        }
       
    }

    func shirtItemCode(customerid:Int,orderno:Int,paperno:Int,trackingid:String)  {
        
        let  newShirt = NSEntityDescription.insertNewObject(forEntityName: "Shirt", into: context)

        newShirt.setValue(trackingid, forKey: "trackingid")
        newShirt.setValue(orderno, forKey: "orderno")
        newShirt.setValue(paperno, forKey: "paperno")
        newShirt.setValue(customerid, forKey: "customerid")
 
        do{
            try context.save()
            print("saved")
        }catch{
            print(error)
        }
    
    }
  
//    func clearData(){
//
//        static var pocket = ""
//        static var placket = ""
//        static var backpleats = ""
//        static var shortSleeve = ""
//        static var tuxedo = ""
//        static var tuxedoPleat = ""
//        static var collarContrastFabric = ""
//        static var cuffContrastFabric = ""
//        static var placketContrastFabric = ""
//        static var sleeveVentContrastFabric = ""
//        static var whiteCuffAndCollar = ""
//        static var contrastFabricCategory = "inner_collar"
//        static var contrastFabricID = ""
//        static var buttonholeColor = ""
//        static var btnType = ""
//
//
//
//    }
    
    func addOnTask(completion:@escaping (Bool,Any?,Error?) -> Void) {
        
        
        StylingTask.pocket = ""
        StylingTask.placket = ""
        StylingTask.backpleats = ""
        StylingTask.shortSleeve = ""
        StylingTask.tuxedo = ""
        StylingTask.tuxedoPleat = ""
        StylingTask.collarContrastFabric = ""
        StylingTask.cuffContrastFabric = ""
        StylingTask.placketContrastFabric = ""
        StylingTask.sleeveVentContrastFabric = ""
        StylingTask.whiteCuffAndCollar = ""
        StylingTask.contrastFabricCategory = "inner_collar"
        StylingTask.contrastFabricID = ""
        StylingTask.buttonholeColor = ""
        StylingTask.btnType = ""
        
        
        DispatchQueue.global().async() {
            
            let defaults = UserDefaults.standard
            let currentTrackingID = defaults.string(forKey: "TRACKINGID")
            let currentOrderNo = defaults.integer(forKey: "ORDERNO")
            let currentCustomerID = defaults.integer(forKey: "CUSTOMERID")
            let currentPaperNo = defaults.integer(forKey: "PAPERNO")
            
            
            let parameters = ["orderNo": "\(currentOrderNo)", "customerID": "\(currentCustomerID)","paperNo": "\(currentPaperNo)", "trackingID": currentTrackingID,"phoneNo":"9999999999"]
            
            print(parameters)
            
            
            guard let url = URL(string: "http://www.bespokino.com/cfc/app.cfc?wsdl&method=addNewOrderItem") else { return }
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
                        print(json)
                        
                        
                        guard let result = json as? [String:Any] else {return}
                        
                        guard let err = result["Error"] as? Bool else {return}
                        
                        if (!err){
                            
                            guard let customerID = result["customerID"] as? Int else {return}
                            
                            guard let orderNO = result["orderNo"] as? Int else {return}
                            
                            guard let paperNO = result["paperNo"] as? Int else{return}
                            
                            guard let trackingID = result["trackingID"] as? String else {return}
                            
                            Order.customerID = customerID
                            Order.orderNo = orderNO
                            Order.paperNo = paperNO
                            Order.trackingID = trackingID
                            
                            let defaults = UserDefaults.standard
                            defaults.set(customerID, forKey: "CUSTOMERID")
                            defaults.set(orderNO, forKey: "ORDERNO")
                            defaults.set(paperNO, forKey: "PAPERNO")
                            defaults.set(trackingID, forKey: "TRACKINGID")
                            defaults.synchronize()
                            
                        }
                        
                        
                        
                        print(err)
                        
                        
                        
                        DispatchQueue.main.async {
                            
                            completion(true, json, nil)
                            
                        }
                    } catch {
                        print(error)
                        DispatchQueue.main.async {
                            
                            completion(false, nil, error)
                            
                        }
                        
                    }
                }
                
                }.resume()
        }
        
        
        
        
        
        
    }
    
    

    
    
}





































