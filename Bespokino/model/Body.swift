//
//  Body.swift
//  Bespokino
//
//  Created by Bespokino on 9/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import Foundation


class Body {
    
    var image:UIImage?
    var name:String?
    
    init(img:UIImage,n:String) {
        
        self.image  = img
        self.name = n
        
    }
 
    init() {
    }
    
    func postBodyPosture ()   {
    
      
        print(BodyPosture.abdomen!)
        print(BodyPosture.chest!)
        print(BodyPosture.pelvis!)
        print(BodyPosture.posture!)
         print(BodyPosture.shoulder!)
        print(Order.userId)
        
        
        let parameters = ["abdomen":BodyPosture.abdomen!, "chest":BodyPosture.chest!,"pelvis":BodyPosture.pelvis!,"shoulders":BodyPosture.shoulder!,"posture":BodyPosture.posture!, "userID":"\(Order.userId)"]
        
        print(parameters)
        
        guard let url = URL(string: "http://www.bespokino.com/cfc/app2.cfc?wsdl&method=updateBodyPostures") else { return }
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
                    
                
                } catch {
                    print(error)
                }
            }
            
            }.resume()
        
    }
    
    }
    
    
    
struct BodyPosture {
    
    static var posture:String?
    static var shoulder:String?
    static var abdomen:String?
    static var chest:String?
    static var pelvis:String?
    
    
}
    
















