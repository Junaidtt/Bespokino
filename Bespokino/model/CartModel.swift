//
//  CartModel.swift
//  Bespokino
//
//  Created by Bespokino on 3/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import Foundation


struct Cart {
    var shirtPrice:Double
    var image:String
    var trackingID:String
}




class CartModel {
    
   
 //   let currentpaperNo = defaults.integer(forKey: "PAPERNO")
    var cartArray = [Cart]()
    func fetchCartItems(completion:@escaping (Bool,[Cart]?,Error?) -> Void) {
        
        let defaults = UserDefaults.standard
        let currentOrderNo = defaults.integer(forKey: "ORDERNO")
        let currentCustomerID = defaults.integer(forKey: "CUSTOMERID")
        DispatchQueue.global().async {
            
            guard let url = URL(string: "http://www.bespokino.com/cfc/app.cfc?wsdl&method=listOrderItem&customerID=\(currentCustomerID)&orderNo=\(currentOrderNo)") else { return }
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
                        guard let array = json as?[Any] else {return}
                        print(array)
                        print(array.count)
                        let defaults = UserDefaults.standard
                        defaults.set(array.count, forKey: "CARTCOUNT")
                        for cart in array{
                            guard let cartDic = cart as? [String:Any] else {return}
                            guard let price = cartDic["shirtPrice"] as? Double else {return}
                            guard let image = cartDic["image"] as? String else {return}
                            guard let trackinfid = cartDic["trackingID"] as? String else {return}
                            let c = Cart(shirtPrice: price, image: image,trackingID:trackinfid)
                            self.cartArray.append(c)
                        }
                        DispatchQueue.main.async {
                            
                            completion(true, self.cartArray, error)

                        }
       
                    } catch {
                        completion(false, nil, error)

                        print(error)
                    }
                    
                }
                }.resume()
            
            
        }
    }
    
    
    func deleteCartItemtask(trackingID:String) {
        
        let defaults = UserDefaults.standard
      //let currentTrackingID = defaults.string(forKey: "TRACKINGID")
        let currentOrderNo = defaults.integer(forKey: "ORDERNO")
        let currentCustomerID = defaults.integer(forKey: "CUSTOMERID")
        let currentpaperNo = defaults.integer(forKey: "PAPERNO")
        let endpoint = trackingID
        print(endpoint)
        let tid = endpoint.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: "http://www.bespokino.com/cfc/app.cfc?wsdl&method=deleteOrderItem&customerID=\(currentCustomerID)&orderNo=\(currentOrderNo)&paperNo=\(currentpaperNo)&trackingID=\(tid)") else { return }
        
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
                    (Order.cartCount) -= 1
                } catch {
                    print(error)
                }
                
            }
            }.resume()
        
        
        
    }
    
    
    
}






















