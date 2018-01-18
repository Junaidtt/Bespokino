//
//  AsyncTask.swift
//  Bespokino
//
//  Created by Bespokino on 11/11/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import Foundation


struct Customer {
    
    static var firstName:String?
    static var lastName:String?
    static  var email:String?
    static var phoneNumber:String?
    static var address:String?
    static var state:String?
    static var zip:String?

}


class AsyncTask: NSObject {
    
    var view:AnyObject?
    var user:User?
    
    init(view:AnyObject,user:User) {
        
        self.view = view
        self.user = user
        
    }
    init(view:AnyObject) {
        self.view = view
    }
   
    override init() {
        
    }
    
    
    
 
    func loginTask(view:AnyObject,user:User)  {
        let urls = "http://www.bespokino.com/cfc/app.cfc?wsdl&method=getUserLoginInfo&Email=\(user.email!)&Password=\(user.password!)&customerID=\(Order.customerID)&orderNo=\(Order.orderNo)&paperNo=\(Order.paperNo)"
        
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
                     guard let customerid = loginResult["customerID"] as? Int else {return}
                    Order.customerID = customerid
                    print(customerid)
                    
                    if (!err){
                        DispatchQueue.main.async {
                            
                            if Order.customerID > 50000{
                            
                            
                                let defaults = UserDefaults.standard
                                defaults.set(true, forKey: "isLoggedIn")
                                defaults.synchronize()
                                
                                
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "InvoiceViewController") as! InvoiceViewController
                            // self.present(newViewController, animated: true, completion: nil)
                            self.view?.navigationController??.pushViewController(newViewController, animated: true)
                            }else{
                                
                                self.displayAlertMessage(messageToDisplay: "SignUp and take measurment")
                                
                            }
                            
                        }
                 
                        
                    }
                    
                    
                } catch {
                    print(error)
                }
                
            }
            }.resume()
        
    }
    
    
    func regUserTask(view:AnyObject,user:User)   {
        
       
        
        let parameters = ["FullName":user.firstName!,"Email":user.email!,"Password":user.password!]
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
                        Customer.firstName = user.firstName
                        Customer.lastName = user.lastName
                      //  guard let message = regResult["Message"] as? String else {return}
                        guard let userid  = regResult["UserId"] as? Int else {return}
                        //guard let modelNo = regResult["modelNo"] as? Int else {return}
                        
                        Order.userId = userid
                       // Order.modelNo = modelNo
                        
                        DispatchQueue.main.async {
                           // self.displayAlertMessage(messageToDisplay: message)
                            let defaults = UserDefaults.standard
                            defaults.set(true, forKey: "isRegIn")
                            defaults.synchronize()
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "BodyPosturesViewController") as! BodyPosturesViewController
                            // self.present(newViewController, animated: true, completion: nil)
                            self.view?.navigationController??.pushViewController(newViewController, animated: true)
                            
                            
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.displayAlertMessage(messageToDisplay: "Registration failed !")
                        }
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
            
            // Code in this block will trigger when OK button tapped.
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
    
    
   
    
    
}


























