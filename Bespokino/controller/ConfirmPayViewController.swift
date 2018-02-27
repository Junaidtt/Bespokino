//
//  ConfirmPayViewController.swift
//  Bespokino
//
//  Created by Bespokino on 1/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import PassKit
import SVProgressHUD

class ConfirmPayViewController: UIViewController,PKPaymentAuthorizationViewControllerDelegate {
   
  
    
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var creditCardView: UIView!
    @IBOutlet weak var checkoutButton: UIButton!
    @objc let SupportedPaymentNetworks = [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex]
    private let applePayMerchantId = "merchant.com.innovationm.applepaydemo"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationItem.title = "BESPOKINO"
        checkoutButton.layer.cornerRadius = 5
        checkoutButton.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
       
        self.totalAmount.text = "$\(String(format: "%.2f", Payment.ccPay!))"


    }

 
    
    @IBAction func checkOutButtonDidTap(_ sender: Any) {
        

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "TransactionViewController") as! TransactionViewController
      
        
        self.navigationController?.pushViewController(newViewController, animated: true)

        
        
        
    }
    
    @IBAction func payWithApplePay(_ sender: Any) {
        
        let supportedNetworks = [ PKPaymentNetwork.amex, PKPaymentNetwork.masterCard, PKPaymentNetwork.visa ]
        
        if PKPaymentAuthorizationViewController.canMakePayments() == false {
            let alert = UIAlertController(title: "Apple Pay is not available", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alert, animated: true, completion: nil)
        }
        
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: supportedNetworks) == false {
            let alert = UIAlertController(title: "No Apple Pay payment methods available", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alert, animated: true, completion: nil)
        }
        
        let request = PKPaymentRequest()
        request.currencyCode = "USD"
        request.countryCode = "US"
        request.merchantIdentifier = "merchant.bespokino.com.Bespokino"
        request.supportedNetworks = SupportedPaymentNetworks
        // DO NOT INCLUDE PKMerchantCapability.capabilityEMV
        request.merchantCapabilities = PKMerchantCapability.capability3DS
        
        
//        let sameDay = PKShippingMethod(label: "Same Day Delivery", amount: 12.99)
//        sameDay.identifier = "sameDay"
//        sameDay.detail = "Guaranteed to be delivered same day."
//
//        let twoDay = PKShippingMethod(label: "Two Day Delivery", amount: 8.99)
//        twoDay.identifier = "twoDay"
//        twoDay.detail = "Guaranteed to be delivered in two days."
        
        let standard = PKShippingMethod(label: "Standard Delivery", amount: 0)
        standard.identifier = "standard"
        standard.detail = "Delivery will be held within 4 - 6 days."
        
        //set the array of shipping methods to the shippingMethods property of payment request
        request.shippingMethods = [standard]
        
       // request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Total", amount: 1.00)]
        request.paymentSummaryItems = self.itemToSell(shipping: 0)

        let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
        applePayController?.delegate = self
        
        self.present(applePayController!, animated: true, completion: nil)
    }
   
    func itemToSell(shipping: Double) -> [PKPaymentSummaryItem] {

      
        print(ApplepayInfo.ccPay!)
        print(ApplepayInfo.subTotalAmount!)
        print(ApplepayInfo.shippingCost!)
        print(ApplepayInfo.totalSalesAmount!)
        print(ApplepayInfo.salesTaxAmount!)
        print(ApplepayInfo.ccPay!)
        let ccpay : NSDecimalNumber = ApplepayInfo.ccPay!
        print(ccpay)
        let stax: NSDecimalNumber = ApplepayInfo.salesTaxAmount!
        //let shipping:NSDecimalNumber = ApplepayInfo.shippingCost!
        //let totalSaleAmt:NSDecimalNumber = ApplepayInfo.totalSalesAmount!
        let totCCpay:NSDecimalNumber = ApplepayInfo.ccPay!
        let sTotal:NSDecimalNumber = ApplepayInfo.subTotalAmount!
        let subtotal = PKPaymentSummaryItem(label: "Subtotal", amount: sTotal)
        let salestax = PKPaymentSummaryItem(label: "Sales Tax", amount:stax)
        let shippingCost = PKPaymentSummaryItem(label: "Shipping ", amount: 0)
      //  let totalSaleAmount = PKPaymentSummaryItem(label: "Total Sales Amount ", amount: totalSaleAmt)
         //let totalAmount = subtotal.amount.adding(discount.amount)
        let total = PKPaymentSummaryItem(label: "Bespokino", amount: totCCpay)
        return [subtotal, salestax, shippingCost,total]
      //  return [total]
        
    }
    
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: (@escaping (PKPaymentAuthorizationStatus) -> Void)) {
        print("paymentAuthorizationViewController delegates called")
        
        if payment.token.paymentData.count > 0 {
            let base64str = self.base64forData(payment.token.paymentData)
            let messsage = String(format: "Data Value: %@", base64str)
            print(base64str)
            print(messsage)
            self.postPaymentTask(base64str: base64str)
            let alert = UIAlertController(title: "Authorization Success", message: messsage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.performApplePayCompletion(controller, alert: alert)
        } else {
            let alert = UIAlertController(title: "Authorization Failed!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            return self.performApplePayCompletion(controller, alert: alert)
        }
    }
    
    @objc func performApplePayCompletion(_ controller: PKPaymentAuthorizationViewController, alert: UIAlertController) {
        controller.dismiss(animated: true, completion: {() -> Void in
            self.present(alert, animated: false, completion: nil)
        })
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
        print("paymentAuthorizationViewControllerDidFinish called")
    }
    
    @objc func base64forData(_ theData: Data) -> String {
        let charSet = CharacterSet.urlQueryAllowed
        
        let paymentString = NSString(data: theData, encoding: String.Encoding.utf8.rawValue)!.addingPercentEncoding(withAllowedCharacters: charSet)
    
        
        return paymentString!
    }
    
    
    func postPaymentTask(base64str:String) -> Void {
        
        print(base64str)
        
        struct Transaction: Codable {
            
            let createTransactionRequest: CreateTransactionRequest
            
        }
        
        struct CreateTransactionRequest: Codable {
            
            let merchantAuthentication: MerchantAuthentication
            let refId: String
            let transactionRequest: TransactionRequest
        }
        
        struct MerchantAuthentication: Codable {
            let name: String
            let transactionKey: String
        }
        
        struct TransactionRequest: Codable {
            let transactionType: String
            let amount: String
            
            let payment: Payment
        }
        struct Payment: Codable {
            
            let opaqueData: OpaqueData
        }
        struct OpaqueData: Codable {
            
            let dataDescriptor: String
            
            let dataValue: String
            
        }
        
        
        
        struct billTo:Codable{
            let firstName:String
            let lastName:String
            let company:String
            let address:String
            let state:String
            let zip:String
            let country:String
            
            
        }
        
        
        let opaqueData = OpaqueData(dataDescriptor: "COMMON.ACCEPT.INAPP.PAYMENT", dataValue: base64str)
        
        let payment  = Payment(opaqueData: opaqueData)
        
        let transactionRequest = TransactionRequest(transactionType: "authCaptureTransaction", amount: "1", payment: payment)
        
        let merchentAuthentication = MerchantAuthentication(name: "785d4yCQ47", transactionKey: "8Qm5kGEK2G28Z2n6")
        
        let createTransactionRequest = CreateTransactionRequest(merchantAuthentication: merchentAuthentication, refId: "123123", transactionRequest: transactionRequest)
        
        
        let transaction = Transaction(createTransactionRequest: createTransactionRequest)
        
        
        
        var postData: String {
            
            
            let ctr = createTransactionRequest
            let ma = ctr.merchantAuthentication
            let ctrtr = ctr.transactionRequest
            let od = ctrtr.payment.opaqueData
            return """
            { "createTransactionRequest":
            { "merchantAuthentication": { "name": "\(ma.name)", "transactionKey": "\(ma.transactionKey)" },
            "refId": "\(ctr.refId)",
            "transactionRequest": {"transactionType": "\(ctrtr.transactionType)", "amount": "\(ctrtr.amount)",
            "payment":
            { "opaqueData": {"dataDescriptor": "\(od.dataDescriptor)", "dataValue": "\(od.dataValue)" } } } } }
            """
            
        }
        
        
        var data: Data {
            
            return Data(postData.utf8)
            
        }
        print(data)
        let postString = String(data: data, encoding: .utf8)!
        print(postString)
        
        guard let url = URL(string: "https://api.authorize.net/xml/v1/request.api") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        do {
            
            request.httpBody = data
        }
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            SVProgressHUD.dismiss()
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    print(json)
                    
                    
                    guard let response = json as? [String: Any] else { return }
                    
                    print(response)
                    
                    guard let transactionResponse = response["transactionResponse"] as? Any else { print("not a dic"); return }
                    
                    print(transactionResponse)
                    
                    guard let transactionDic = transactionResponse as? [String:Any] else {return}
                    
                    guard let responseCode = transactionDic["responseCode"] as? String else {return}
                    
                    print("\(responseCode)")
                    
                    DispatchQueue.main.async {
                        
                        
                        if responseCode == "1"{
                            
                            if ccPayAmt! == 20.0{
                                //self.postTwentyPayment()
                            }else {
                                self.FinalOrderPlacementTask()
                                
                            }
                            
                            
                            DispatchQueue.main.async {
                                
                                self.displayAlertMessage(messageToDisplay: "Your transaction has Approved", title: "success")
                                
                            }
                        }else if responseCode == "2"{
                            
                            
                            
                            guard let avsResultCode = transactionDic["avsResultCode"] as? String else {return}
                            
                            if avsResultCode == "A"{
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Address (Street) matches, ZIP does not,Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "B"{
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Address information not provided for AVS check,Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "E"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: " Address verification error,Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "G"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Non-U.S. Card Issuing Bank,Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "P"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: " Address verification not applicable for this transaction.Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "R"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Retry — System unavailable or timed out.Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "S"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Service not supported by issuer.Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "U"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Address information is unavailable.Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "W"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Nine digit ZIP matches, Address (Street) does not.Try Again ", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "Z"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: " Five digit ZIP matches, Address (Street) does not. Try Again", title: "Declined")
                                    
                                }
                                
                            }
                            
                        }
                        else if responseCode == "3"{
                            
                            guard let avsResultCode = transactionDic["avsResultCode"] as? String else {return}
                            
                            if avsResultCode == "A"{
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Address (Street) matches, ZIP does not,Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "B"{
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Address information not provided for AVS check,Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "E"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: " Address verification error,Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "G"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Non-U.S. Card Issuing Bank,Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "P"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: " Address varification service not applicable for this transaction.Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "R"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Retry — System unavailable or timed out.Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "S"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Service not supported by issuer.Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "U"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Address information is unavailable.Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "W"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Nine digit ZIP matches, Address (Street) does not.Try Again ", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "Z"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: " Five digit ZIP matches, Address (Street) does not. Try Again", title: "Declined")
                                    
                                }
                                
                            }
                            
                        }else if responseCode == "4"{
                            
                            DispatchQueue.main.async {
                                self.displayAlertMessage(messageToDisplay: "Your transaction has been held for review", title: "Transaction Held")
                                
                            }
                            
                            
                        }
                        
                    }
                    
                } catch {
                    print(error)
                }
            }
            
            }.resume()
        
    }
    
    func displayAlertMessage(messageToDisplay: String,title:String)
    {
        let alertController = UIAlertController(title: title, message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
    
    
    func displayAlert()  {
        let topWindow = UIWindow(frame: UIScreen.main.bounds)
        topWindow.rootViewController = UIViewController()
        topWindow.windowLevel = UIWindowLevelAlert + 1
        let alert = UIAlertController(title: "No Internet", message: "please check your internet connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "confirm"), style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
            // continue your work
            // important to hide the window after work completed.
            // this also keeps a reference to the window until the action is invoked.
            topWindow.isHidden = true
        }))
        topWindow.makeKeyAndVisible()
        topWindow.rootViewController?.present(alert, animated: true, completion: nil)
    }

    func FinalOrderPlacementTask()  {
        
        guard let url = URL(string: "http://www.bespokino.com/cfc/app3.cfc?wsdl&method=placeOrderAndCreatePDF&customerID=\(Order.customerID)&orderNo=\(Order.orderNo)&paperNo=\(Order.paperNo)") else { return }
        
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
                } catch {
                    print(error)
                }
                
            }
            }.resume()
        
    }
    /*
    func postTwentyPayment(){
        
        let ccLastNo = String(self.cardNumber.suffix(4))
         let ccLastNo = "1234"
        print(ccLastNo)
        let parameters = """
        {"firstName":\(Customer.firstName!),"lastName":\(Customer.lastName!),"email":\(Customer.email!),
        "phoneNo":\(Customer.phoneNumber!),"userId":\(Order.userId), "ccType":"xxx","ccNo":\(self.cardNumber),  "ccExpMonth":\(self.cardExpirationMonth),"ccExpYear":\(self.cardExpirationYear),"ccCode":\(cardVerificationCode), "address":\(Customer.address!), "city":\(Customer.state),"state":\(Customer.state),"zip":\(Customer.zip!),"ccLastNo":\(ccLastNo)}
        """
        
        
        print(parameters)
        
        
        guard let url = URL(string: "http://www.bespokino.com/cfc/app2.cfc?wsdl&method=CustomerMeasuringToolDeposit") else { return }
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
        
    }*/
    
    
    
}
