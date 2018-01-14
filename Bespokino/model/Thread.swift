//
//  Thread.swift
//  Bespokino
//
//  Created by Bespokino on 11/17/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import Foundation


struct ThreadCode {
    
    static var selectedThreadCode = ""
    static var selectedIndex:Int?
}

class Thread :NSObject{

    var name:String?
    var imageCode:Int?
    
    init(name:String,imgCode:Int) {
        
        self.name = name
        self.imageCode = imgCode
        
    }
    
    override init() {
        
    }
    
    var menuItems = [["Image" : "t6811", "code" : "1"], ["Image" : "t1796", "code" : "2"],["Image" : "t6010", "code" : "3"],["Image" : "t2480", "code" : "4"],["Image" : "t6614", "code" : "5"],
         
                     ["Image" : "t1861", "code" : "6"], ["Image" : "t6711", "code" : "7"],["Image" : "t6768", "code" : "8"],["Image" : "t6463", "code" : "9"],["Image" : "t6040", "code" : "10"],
                     
                     
        ["Image" : "t6046", "code" : "11"], ["Image" : "t1502", "code" : "12"],["Image" : "t6536", "code" : "13"],["Image" : "t6537", "code" : "14"],["Image" : "t1629", "code" : "15"],
        
        ["Image" : "t2331", "code" : "16"], ["Image" : "t6603", "code" : "17"],["Image" : "t1614", "code" : "18"],["Image" : "t6800", "code" : "19"],["Image" : "t2424", "code" : "20"],
                     
                     
        ["Image" : "t6403", "code" : "21"], ["Image" : "t1419", "code" : "22"],["Image" : "t6211", "code" : "23"],["Image" : "t6224", "code" : "24"],["Image" : "t6213", "code" : "25"],
        
        ["Image" : "t6211", "code" : "26"], ["Image" : "t1193", "code" : "27"],["Image" : "t1700", "code" : "28"],["Image" : "t1532", "code" : "29"],["Image" : "t1987", "code" : "30"],
    
        
            ["Image" : "t1853", "code" : "31"], ["Image" : "t6543", "code" : "32"],["Image" : "t6132", "code" : "33"],["Image" : "t6237", "code" : "34"],["Image" : "t6141", "code" : "35"],
            
            ["Image" : "t1717", "code" : "36"]
                     ]

    
    var contrast = [Thread]()
    
    
    func fetchContrastFabric(completion:@escaping (Bool,Any?,Error?) -> Void) {
    
      
        DispatchQueue.main.async {
            
            
            guard let url = URL(string: "http://www.bespokino.com/cfc/app.cfc?wsdl&method=populateFabrics&categoryID=5") else { return }
            
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
                    guard let array = json as? [Any] else { return }
                        
                        for t in array{
                            guard let threadDic = t as?[String:AnyObject] else {return}
                            guard let fabid  = threadDic["fabricID"] as? Int else {return}
                            guard let fabImage = threadDic["image"] as? String else {return}
                            let c = Thread(name: fabImage, imgCode: fabid)
                            self.contrast.append(c)
                        }
                      

                       
                        DispatchQueue.main.async {
                            completion(true,self.contrast,nil)

                        }
                        
                        
                    } catch {
                        completion(true,nil,error)

                        print(error)
                    }
                    
                }
                }.resume()
            
            
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
}























