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
}




class CartModel {
    var cartArray = [Cart]()
    func fetchCartItems(completion:@escaping (Bool,[Cart]?,Error?) -> Void) {
        DispatchQueue.global().async {
            
            guard let url = URL(string: "http://www.bespokino.com/cfc/app.cfc?wsdl&method=listOrderItem&customerID=8939&orderNo=7580638") else { return }
            
            let session = URLSession.shared
            session.dataTask(with: url) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                
                if let data = data {
                    print(data)
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
             
                        guard let array = json as?[Any] else {return}
                        
                        for cart in array{
                            guard let cartDic = cart as? [String:Any] else {return}
                            guard let price = cartDic["shirtPrice"] as? Double else {return}
                            guard let image = cartDic["image"] as? String else {return}

                            let c = Cart(shirtPrice: price, image: image)
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
    
    
    
    
}






















