//
//  AsyncTask.swift
//  Bespokino
//
//  Created by Bespokino on 11/11/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import Foundation
import CoreData

struct Customer {
    
    static var firstName:String?
    static var lastName:String?
    static var email:String?
    static var phoneNumber:String?
    static var address:String?
    static var state:String?
    static var zip:String?

}


class AsyncTask: NSObject {
    
    var view:AnyObject?
    var user:User?
    let defaults = UserDefaults.standard

  //  let db = Databasehandler()
    init(view:AnyObject,user:User) {
        
        self.view = view
        self.user = user
        
    }
    init(view:AnyObject) {
        self.view = view
    }

    override init() {
        
    }
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func loginTask(view:AnyObject,user:User)  {
        
        let urls = "http://www.bespokino.com/cfc/app.cfc?wsdl&method=getUserLoginInfo&Email=\(user.email!)&Password=\(user.password!)&customerID=&orderNo=&paperNo="
   
        
        guard let url = URL(string: urls) else { return }
        
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

                    guard let loginResult = json as? [String:Any] else {return}
                    guard let err = loginResult["Error"] as? Bool else {return}
                    guard let email = loginResult["Email"] as? String else {return}
                    guard let customerid = loginResult["UserId"] as? Int else {return}
                    guard let fullname = loginResult["FullName"] as? String else {return}
                    guard let phoneNumber = loginResult["PhoneNo"] as? String else {return}
                    guard let state = loginResult["State"] as? String else {return}

                    guard let zip = loginResult["Zip"] as? Int else {return}
                    guard let address = loginResult["Address"] as? String else {return}
                  
                    guard let city = loginResult["City"] as? String else {return}
                    guard let measurment = loginResult["Measurements"] as? Bool else {return}

                    
                    self.defaults.set(customerid, forKey: "USERID")
                    self.defaults.set(fullname, forKey: "FULLNAME")
                    
                    if measurment{
                        self.defaults.set(true, forKey: "BESPOKE")
                    }else{
                        self.defaults.set(false, forKey: "BESPOKE")

                    }
                    self.defaults.synchronize()

                    Order.customerID = customerid
                    print(customerid)
                    print(err)
                    if (!err){
 
                        self.deleteAllRecords()
                        
                        self.userLocalStorage(fullName: fullname, email: email,customerID: customerid, phoneNumber: phoneNumber, address: address, city: city, state: state, zip: zip)
    
                        DispatchQueue.main.async {
                            
                            if Order.customerID > 50000{
             
                                self.defaults.set(true, forKey: "isRegIn")
                                self.defaults.synchronize()
        
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                             self.view?.present(newViewController, animated: true, completion: nil)

                          
                            }else{
                                
                                self.displayAlertMessage(messageToDisplay: "SignUp and take measurment")
                            }
                            
                        }
           
                    }else{
                        
                        DispatchQueue.main.async {
                            self.displayAlertMessage(messageToDisplay: "Login credentials are wrong. Please try again")

                        }
                    }
                } catch {
                    print(error)
                }
                
            }
            }.resume()
        
    }
    
    
    func regUserTask(view:AnyObject,user:User)   {
   
        let parameters = ["FullName":user.firstName!,"Email":user.email!,"Password":user.password!,"clientID": ""]
        print(parameters)
        guard let url = URL(string: "http://www.bespokino.com/cfc/app.cfc?wsdl&method=CustomerSignup") else { return }
        
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
                    
                    guard let regResult = json as? [String:Any] else {return}

                    guard let err = regResult["Error"] as? Bool else {return}
                    
                    if (!err){
                        
                        let defaults = UserDefaults.standard
                        defaults.set(true, forKey: "isRegIn")
                        defaults.synchronize()
                        
                        Customer.firstName = user.firstName
                        Customer.lastName = user.lastName

                      // defaults.set(user.firstName, forKey: "FULLNAME")
                        defaults.set(user.email, forKey: "EMAIL")
                        
                        
                        //guard let message = regResult["Message"] as? String else {return}
                        guard let userid  = regResult["UserId"] as? Int else {return}
                        
                        guard let email = regResult["Email"] as? String else {return}
                        guard let customerid = regResult["UserId"] as? Int else {return}
                        guard let fullname = regResult["FullName"] as? String else {return}
                        guard let phoneNumber = regResult["PhoneNo"] as? String else {return}
                        guard let state = regResult["State"] as? String else {return}
                  
                        guard let zip = regResult["Zip"] as? Int else {return}
                        guard let address = regResult["Address"] as? String else {return}
                        guard let city = regResult["City"] as? String else {return}
                        guard let measurment = regResult["Measurements"] as? Bool else {return}

                      
                        //guard let modelNo = regResult["modelNo"] as? Int else {return}
                        self.defaults.set(customerid, forKey: "USERID")
                        self.defaults.set(fullname, forKey: "FULLNAME")
                        if measurment{
                            self.defaults.set(true, forKey: "BESPOKE")
                        }else{
                            self.defaults.set(false, forKey: "BESPOKE")
                            
                        }
                        defaults.synchronize()
                        self.deleteAllRecords()
                        self.userLocalStorage(fullName: fullname, email: email,customerID: customerid, phoneNumber: phoneNumber, address: address, city: city, state: state, zip: zip)
                        
                        Order.userId = userid
                        // Order.modelNo = modelNo
                        
                        DispatchQueue.main.async {

                            // self.view?.dismiss(animated: true)
                            // self.displayAlertMessage(messageToDisplay: message)
                             let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                             let newViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                             self.view?.present(newViewController, animated: true, completion: nil)
                         //    self.view?.navigationController??.pushViewController(newViewController, animated: true)
                            
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.displayAlertMessage(messageToDisplay: "Registration failed !")
                        }
                    }

                }
                catch{
                    print(error)
                    }
                }
            }.resume()
    }
    
    
     func socialRegister(fullname:String,uniqueid:String){
        
            let parameters =    ["Password": "", "Email": "", "FullName": fullname,"clientID": uniqueid]
        print(parameters)
        guard let url = URL(string:"http://www.bespokino.com/cfc/app.cfc?wsdl&method=CustomerSignup") else { return }
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
                    
                    guard let regResult = json as? [String:Any] else {return}
                    
                    guard let err = regResult["Error"] as? Bool else {return}
                    
                    if (!err){
                        
                        let defaults = UserDefaults.standard

                        guard let userid  = regResult["UserId"] as? Int else {return}
                        
                        guard let email = regResult["Email"] as? String else {return}
                        guard let customerid = regResult["UserId"] as? Int else {return}
                        guard let fullname = regResult["FullName"] as? String else {return}
                        guard let phoneNumber = regResult["PhoneNo"] as? String else {return}
                        guard let state = regResult["State"] as? String else {return}
                        guard let zip = regResult["Zip"] as? Int else {return}
                        guard let address = regResult["Address"] as? String else {return}
                        guard let city = regResult["City"] as? String else {return}
                        //guard let modelNo = regResult["modelNo"] as? Int else {return}
                        guard let measurment = regResult["Measurements"] as? Bool else {return}

                        defaults.set(customerid, forKey: "USERID")
                        defaults.set(true, forKey: "isRegIn")
                        if measurment{
                            self.defaults.set(true, forKey: "BESPOKE")
                        }else{
                            self.defaults.set(false, forKey: "BESPOKE")
                            
                        }
                        defaults.synchronize()
        
                        self.deleteAllRecords()
                     
                        self.userLocalStorage(fullName: fullname, email: email,customerID: customerid, phoneNumber: phoneNumber, address: address, city: city, state: state, zip: zip)
                        
                        Order.userId = userid
                 
                    }
                    
                } catch {
                    print(error)
                }
            }
            
            }.resume()
    }

    //Email validation
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    
    //Alert message
    
    func displayAlertMessage(messageToDisplay: String)
    {
        let alertController = UIAlertController(title: "info", message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            print("Ok button tapped");
            
        }
        
        alertController.addAction(OKAction)
        
        self.view?.present(alertController, animated: true, completion:nil)
    }
    
    //Phone validation
    
    func validatePg(value: String) -> Bool {
        let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    func userLocalStorage(fullName:String?,email:String?,customerID:Int?,phoneNumber:String?,address:String?,city:String?,state:String?,zip:Int?){
        
        
        print(email ?? "No email")
        
        
        let  newCustomer = NSEntityDescription.insertNewObject(forEntityName: "CustomerInfo", into: context)

        newCustomer.setValue(fullName, forKey: "fullName")
        newCustomer.setValue(email!, forKey: "email")
        newCustomer.setValue(customerID!, forKey: "customerID")
        newCustomer.setValue(phoneNumber, forKey: "cellNumber")
        newCustomer.setValue(address, forKey: "shippingAddress")
        newCustomer.setValue(city, forKey: "shippingCity")
        newCustomer.setValue(zip, forKey: "shippingPostalcode")
        newCustomer.setValue(state, forKey: "state")
        newCustomer.setValue(customerID, forKey: "userId")
  
        do{
            try context.save()
            print("saved")
        }catch{
            print(error)
        }
   
    }
    func deleteAllRecords() {
        //delete all data
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CustomerInfo")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("removed user information")
        } catch {
            print ("There was an error")
        }
    }
    
}


























