//
//  InvoiceTask.swift
//  Bespokino
//
//  Created by Bespokino on 30/11/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import Foundation

struct Payment {

   static var ccPay :Double?

}



struct Invoice{
    
    var totalPrice:Double
    var country:String
    var paperNo:Int32
    var zip:String
    var StylingAddup:Double
    var firstName:String
    var lastName:String
    var city:String
    var subTotalAmount:Double
    var orderNo:Int32
    var state:String
    var totalSalesAmount:Double
    var paidByCCAmount:Double
    var customerID:Int32
    var salesTaxAmount:Double
    var Description:String
    var address:String
    var BasicPrice:Double
    var shippingCost:Double
    var FabricUpgrade:Double
    
}

class InvoiceTask: NSObject {
    
    var invoiceArray = [Invoice]()
    let url = "http://www.bespokino.com/cfc/app.cfc?wsdl&method=getInvoiceInfo&orderNo=\(Order.orderNo)&customerID=\(Order.customerID)"

    
    func getInvoiceTask(completion:@escaping (Bool,[Invoice]?,Error?)->Void){
    
        
        
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
                    
                    guard let arrayInvoice = json as? [Any] else { return }
                    
                    print(arrayInvoice)
                    
                    for invoice in arrayInvoice{
                        
                        guard let invoiceDic = invoice as? [String:Any] else {return}
                        //  print(invoiceDic)
                        
                        guard let description = invoiceDic["Description"] as? String else {return}
                        guard let paidByCCAmount = invoiceDic["paidByCCAmount"] as? Double else {return}
                        guard let city = invoiceDic["city"] as? String else {return}
                        guard let customerID = invoiceDic["customerID"] as? Int32 else {return}
                        guard let state = invoiceDic["state"] as? String else {return}
                        guard let shippingCost = invoiceDic["shippingCost"] as? Double else {return}
                        guard let FabricUpgrade = invoiceDic["FabricUpgrade"] as? Double else {return}
                        guard let salesTaxAmount = invoiceDic["salesTaxAmount"] as? Double else {return}
                        guard let lastName = invoiceDic["lastName"] as? String else {return}
                        guard let address = invoiceDic["address"] as? String else {return}
                        guard let paperNo = invoiceDic["paperNo"] as? Int32 else {return}
                        guard let totalSalesAmount = invoiceDic["totalSalesAmount"] as? Double else {return}
                        guard let BasicPrice = invoiceDic["BasicPrice"] as? Double else {return}
                        guard let zip = invoiceDic["zip"] as? String else {return}
                        guard let subTotalAmount = invoiceDic["subTotalAmount"] as? Double else {return}
                        guard let firstName = invoiceDic["firstName"] as? String else {return}
                        guard let TotalPrice = invoiceDic["TotalPrice"] as? Double else {return}
                        guard let orderNo = invoiceDic["orderNo"] as? Int32 else {return}
                        guard let StylingAddup = invoiceDic["StylingAddup"] as? Double else {return}
                        guard let country = invoiceDic["country"] as? String else {return}
                        
                        let invoiceData = Invoice(totalPrice: TotalPrice, country: country, paperNo: paperNo, zip: zip, StylingAddup: StylingAddup, firstName: firstName, lastName: lastName, city: city, subTotalAmount: subTotalAmount, orderNo: orderNo, state: state, totalSalesAmount: totalSalesAmount, paidByCCAmount: paidByCCAmount, customerID: customerID, salesTaxAmount: salesTaxAmount, Description: description, address: address, BasicPrice: BasicPrice, shippingCost: shippingCost, FabricUpgrade: FabricUpgrade)
                        
                        print(invoiceData)
                        self.invoiceArray.append(invoiceData)
                        
                    
                        
                        
                    }
                    completion(true, self.invoiceArray, nil)
                    
                    
                } catch {
                    
                    completion(true, nil, error)
                    
                    print(error)
                }
                
            }
            }.resume()
        
        
    }

    
    
    
}







