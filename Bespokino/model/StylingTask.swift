//
//  StylingTask.swift
//  Bespokino
//
//  Created by Bespokino on 11/20/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import Foundation
import CoreData
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
        let collar2 = StylingTask(name: "SEMI WIDE SPREAD", image: UIImage(named: "Collar_b")!, optionVal: 192)
        let collar3 = StylingTask(name: "WIDE SPREAD", image: UIImage(named: "collar_wide")!, optionVal: 192)
        let collar4 = StylingTask(name: "ROUND EDGE", image: UIImage(named: "Collar_c")!, optionVal: 193)
        let collar5 = StylingTask(name: "BUTTON DOWN", image: UIImage(named: "Collar_d")!, optionVal: 194)
        let collar6 = StylingTask(name: "MANDARIN", image: UIImage(named: "Collar_e")!, optionVal: 195)
        item.append(collar1)
        item.append(collar2)
        item.append(collar3)
        item.append(collar4)
        item.append(collar5)
        item.append(collar6)
        completion(item)
        
        
    }
    
    func getAddOptiondata(completion:([StylingTask]) -> Void) {
        
        var item = [StylingTask]()

        let addOptiom1 = StylingTask(name: "POCKET", image: UIImage(named: "pocket")!, optionVal: 187)
        let addOptiom2 = StylingTask(name: "TUXEDO", image: UIImage(named: "tuxedo_pleats")!, optionVal: 528)
        let addOptiom3 = StylingTask(name: "CONTRAST", image: UIImage(named: "contrast_new")!, optionVal: 547)
        let addOptiom4 = StylingTask(name: "BUTTON HOLE & THREAD", image: UIImage(named: "thread")!, optionVal: 547)
        let addOptiom5 = StylingTask(name: "WHITE COLLAR & CUFF", image: UIImage(named: "whitec")!, optionVal: 206)
        let addOptiom6 = StylingTask(name: "PLACKET", image: UIImage(named: "placket")!, optionVal: 159)
        let addOptiom7 = StylingTask(name: "PLEAT", image: UIImage(named: "twopleats")!, optionVal: 156)
        let addOptiom8 = StylingTask(name: "SHORT SLEEVE", image:UIImage(named: "short_sleev")!, optionVal: 208)
        
        
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
    
    func cuffInsertionTask(code:Int,completion:@escaping (Bool,Any?,Error?) -> Void) {
        
        let defaults = UserDefaults.standard
        let currentTrackingID = defaults.string(forKey: "TRACKINGID")
        let currentOrderNo = defaults.integer(forKey: "ORDERNO")
        let currentCustomerID = defaults.integer(forKey: "CUSTOMERID")
        let currentPaperNo = defaults.integer(forKey: "PAPERNO")
        
        print(currentTrackingID!)
        print(currentOrderNo)
        print(currentCustomerID)
        print(currentPaperNo)
        
        
        DispatchQueue.global().async {
            
            
            let parameters = ["orderNo": "\(currentOrderNo)", "customerID": "\(currentCustomerID)","paperNo": "\(currentPaperNo)", "trackingID": currentTrackingID!,"optionValue":"\(code)"]
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
    
    //monoText,self.monoStyle,self.threadCode,self.positionSelected
    func monogramInserttask(monoTxt:String,style:String,threadCode:String,position:String,completion:@escaping (Bool,Any?,Error?) -> Void) {
        
        
        let defaults = UserDefaults.standard
        let currentTrackingID = defaults.string(forKey: "TRACKINGID")
        let currentOrderNo = defaults.integer(forKey: "ORDERNO")
        let currentCustomerID = defaults.integer(forKey: "CUSTOMERID")
        let currentpaperNo = defaults.integer(forKey: "PAPERNO")
        
        print(currentTrackingID!)
        print(currentOrderNo)
        print(currentCustomerID)
        print(currentpaperNo)
        DispatchQueue.global().async {
       
      let parameters = ["orderNo": "\(currentOrderNo)", "customerID": "\(currentCustomerID)","paperNo": "\(currentpaperNo)", "trackingID": currentTrackingID!,"mgLine":monoTxt,"mgColor":threadCode,"mgPosition":position,"mgStyle":style]
            
            print(parameters)
            
            guard let url = URL(string: "http://www.bespokino.com/cfc/app.cfc?wsdl&method=insertMonogramStylingInfo") else { return }
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

    func collarInsertionTask(code:Int,completion:@escaping (Bool,Any?,Error?) -> Void) {
   
        let defaults = UserDefaults.standard
        let currentTrackingID = defaults.string(forKey: "TRACKINGID")
        let currentOrderNo = defaults.integer(forKey: "ORDERNO")
        let currentCustomerID = defaults.integer(forKey: "CUSTOMERID")
        let currentpaperNo = defaults.integer(forKey: "PAPERNO")
        
        print(currentTrackingID!)
        print(currentOrderNo)
        print(currentCustomerID)
        print(currentpaperNo)
        
        
        
        DispatchQueue.global().async {
            
            let parameters = ["orderNo": "\(currentOrderNo)", "customerID": "\(currentCustomerID)","paperNo": "\(currentpaperNo)", "trackingID": "\(currentTrackingID!)","optionValue":"\(code)"]
          //  let parameters = ["orderNo": "\(Order.orderNo)", "customerID": "\(Order.customerID)","paperNo": "\(Order.paperNo)", "trackingID": "\(Order.trackingID)","optionValue":"\(code)"]
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


    
    
    
    

    
    
    func setCurrentOrder(){
        
        let defaults = UserDefaults.standard
        let currentTrackingID = defaults.string(forKey: "TRACKINGID")
        let currentOrderNo = defaults.integer(forKey: "ORDERNO")
        let currentCustomerID = defaults.integer(forKey: "CUSTOMERID")
        let currentPaperNo = defaults.integer(forKey: "PAPERNO")
        
        print(currentTrackingID!)
        print(currentOrderNo)
        print(currentCustomerID)
        print(currentPaperNo)
        
        Order.orderNo = currentOrderNo
        Order.customerID = currentCustomerID
        Order.paperNo = currentPaperNo
        Order.trackingID = currentTrackingID!
        
        
    }
    
    
    func postAdditionalOptins(completion:@escaping (Bool,Any?,Error?)->Void)  {

      //  setCurrentOrder()
      //  print(StylingTask.add_json)
        
        let defaults = UserDefaults.standard
        let currentTrackingID = defaults.string(forKey: "TRACKINGID")
        let currentOrderNo = defaults.integer(forKey: "ORDERNO")
        let currentCustomerID = defaults.integer(forKey: "CUSTOMERID")
        let currentPaperNo = defaults.integer(forKey: "PAPERNO")
        
        var add_json = """
        {"orderNo":"\(currentOrderNo)","customerID":"\(currentCustomerID)","paperNo":"\(currentPaperNo)",
        "trackingID": "\(currentTrackingID!)", "placket":"\(StylingTask.placket)",
        "backPleats":"\(StylingTask.backpleats)", "pocket":"\(StylingTask.pocket)", "shortSleeve":"\(StylingTask.shortSleeve)",
        "tuxedo":"\(StylingTask.tuxedo)", "tuxedoPleat":"\(StylingTask.tuxedoPleat)", "collarContrastFabric":"\(StylingTask.collarContrastFabric)",
        "cuffContrastFabric":"\(StylingTask.cuffContrastFabric)", "placketContrastFabric":"\(StylingTask.placketContrastFabric)",
        "sleeveVentContrastFabric":"\(StylingTask.sleeveVentContrastFabric)", "whiteCuffAndCollar":"\(StylingTask.whiteCuffAndCollar)",
        "contrastFabricCategory":"inner_collar", "contrastFabricID":"\(StylingTask.contrastFabricID)",
        "buttonholeColor":"\(StylingTask.buttonholeColor)", "btnType":"Save"}
        """
        
        print(add_json)
        DispatchQueue.global().async {
           var data: Data { return Data(add_json.utf8) }
            
            print(data)
            
           guard let url = URL(string: "http://www.bespokino.com/cfc/app.cfc?wsdl&method=insertAdditionalOptionStylingInfo") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           // guard let httpBody = try? JSONSerialization.data(withJSONObject: data, options: []) else { return }
           
            
            do {
                
                request.httpBody = data
            }
 
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
func getShirtInfo()  {

    var shirtArray:[Shirt] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    do{
        shirtArray = try context.fetch(Shirt.fetchRequest()) as! [Shirt]
        
        print(shirtArray.count)
        
        for shirt in shirtArray{
                  print(shirt.trackingid!)
        }
        
        print(shirtArray[0].customerid)
        print(shirtArray[0].orderno)
        print(shirtArray[0].trackingid!)
        
        
        
        
    }catch{
        
        print(error)
        
    }
}
struct AdditionalOptions {
    
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
    
}










