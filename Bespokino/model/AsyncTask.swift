//
//  AsyncTask.swift
//  Bespokino
//
//  Created by Bespokino on 11/11/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
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
    
    let url = "http://www.bespokino.com/cfc/app.cfc?wsdl&method=getUserLoginInfo&Email=fred.hakim@gemmasuits.com&Password=fred123&customerID=2221&orderNo=4380179&paperNo=50541"
    
    func loginTask(user:User)  {
        
        guard let url = URL(string: url) else { return }
        
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
                    
                    guard let email = loginResult["Email"] as? String else {return}
                    
                    print(email)
                    
                    
                    
                } catch {
                    print(error)
                }
                
            }
            }.resume()
        
    }
    
    
    func regUserTask(view:AnyObject,user:User)   {
        
        let parameters = ["FirstName":user.firstName,"LastName":user.lastName,"Email":user.email,"Password":user.password,"PhoneNo":user.phoneNumber, "pantsWaist":user.pantWaistSize]
        
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
                        
                        guard let message = regResult["Message"] as? String else {return}
                        
                        
                        DispatchQueue.main.async {
                           // self.displayAlertMessage(messageToDisplay: message)
                            
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
        let alertController = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: .alert)
        
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


























