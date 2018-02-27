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
    
    static func postBodyPosture (completion:@escaping (Int) -> Void)   {

        let defaults = UserDefaults.standard
        let (yesBody) = defaults.bool(forKey: "YESBODY")
        if yesBody {
            let posture =  defaults.string(forKey: "POSTURECODE")
            let shoulder = defaults.string(forKey: "SHOULDERCODE")
            let chest = defaults.string(forKey: "CHESTCODE")
            let abdomen = defaults.string(forKey: "ABDOMENCODE")
            let pelvis = defaults.string(forKey: "PELVISCODE")
            
            print(posture!)
            print(shoulder!)
            print(chest!)
            print(abdomen!)
            print(pelvis!)
            
        let parameters = ["abdomen":abdomen!, "chest":chest!,"pelvis":pelvis!,"shoulders":shoulder!,"posture":posture!, "userID":"\(Order.userId)","pantsWaist":"\(BodyPosture.pantWaistSize!)"]
            
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
                   guard let result = json as? [String: Any] else { return }
                    guard let modelNo = result["modelNo"] as? Int else {return}
                    Order.modelNo = modelNo
                   completion(modelNo)
                } catch {
                    print(error)
                }
            }
            }.resume()
        }
    }
    
    }
    
    
    
struct BodyPosture {
    
    static var posture:String?
    static var shoulder:String?
    static var abdomen:String?
    static var chest:String?
    static var pelvis:String?
    static var pantWaistSize:String?
    
    
}
    
















