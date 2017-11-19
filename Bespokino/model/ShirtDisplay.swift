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
        
        print("GET CUSTOMER DETAILS")
        
        DispatchQueue.global().async() {
           let parameters = ["orderNo": "@0", "customerID": "0","paperNo": "0", "trackingID": "0","fabricID":"108"]
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
                            
                            let  newOrder = NSEntityDescription.insertNewObject(forEntityName: "OrderInfo", into: self.context)
                           
                            newOrder.setValue(customerID, forKey: "customerID")
                            
                            newOrder.setValue(orderNO, forKey: "orderNo")

                            newOrder.setValue(paperNO, forKey: "paperNo")

                            newOrder.setValue(trackingID, forKey: "trackingID")

                            do{
                                try self.context.save()
                                print("ORDER INFO SAVED")
                            }catch{
                                print(error)
                            }
                            
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





































