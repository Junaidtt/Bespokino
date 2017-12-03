//
//  InvoiceViewController.swift
//  Bespokino
//
//  Created by Bespokino on 30/11/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class InvoiceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   

    var data = [Invoice]()
    let invoiceTask = InvoiceTask()
    
    @IBOutlet weak var addressTextField2: UILabel!
    @IBOutlet weak var addressTextField: UILabel!
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var customerTextField: UILabel!
    @IBOutlet weak var orderNoTextField: UILabel!
    
    @IBOutlet weak var subTotalPrice: UILabel!
    @IBOutlet weak var salesTaxPrice: UILabel!
    @IBOutlet weak var totalSalesAmount: UILabel!
    @IBOutlet weak var shipmentPrice: UILabel!
    @IBOutlet weak var paidByCC: UILabel!
    
    
    @IBOutlet weak var invoiceTableView: UITableView!
    @IBOutlet weak var payButton: UIButton!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "BESPOKINO"
        payButton.layer.cornerRadius = 5
        payButton.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    
        invoiceTask.getInvoiceTask { (success, result, error) in
            
          
            
            if success{
                self.data = result!
                DispatchQueue.main.async {
                    if (self.data.count>0){
                        self.nameTextField.text = "\(self.data[0].firstName) \(self.data[0].lastName)"
                        self.addressTextField.text = "\(self.data[0].address)"
                        self.addressTextField2.text = "\(self.data[0].state) \(self.data[0].zip) \(self.data[0].country)"
                        self.dateText.text = "Date: \(self.getCurrentDate())"
                        self.customerTextField.text = "Customer: \(self.data[0].customerID)"
                        self.orderNoTextField.text = "Order Number: \(self.data[0].orderNo)"
                        self.subTotalPrice.text = "$\(String(format: "%.2f",self.data[0].subTotalAmount))"
                        self.salesTaxPrice.text = "$\(String(format: "%.2f",self.data[0].salesTaxAmount))"
                        self.shipmentPrice.text = "$\(String(format: "%.2f",self.data[0].shippingCost))"
                        self.paidByCC.text = "$\(String(format: "%.2f",self.data[0].paidByCCAmount))"
                        self.totalSalesAmount.text = "$\(String(format: "%.2f",self.data[0].totalSalesAmount))"
                        self.invoiceTableView.reloadData()
                    }
                }
                
            }
            
        }
       
        
      //  print(data[0].firstName)
    
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "invoice", for: indexPath)as! InvoiceTableViewCell
        
        
        if (self.data.count>0)
        {
            //String(format: "%.2f", myDouble)
        cell.shirtPrice.text = "$"+String(format: "%.2f",data[indexPath.row].BasicPrice)
        cell.fabricUpgradePrice.text = "$"+String(format: "%.2f",data[indexPath.row].FabricUpgrade)
        cell.shirtCount.text = "\(data.count) Custome made shirt"
        cell.stylingPrice.text = "$"+String(format: "%.2f",data[indexPath.row].StylingAddup)
        
        }
        
        return cell
        
    }
    @IBAction func payButtonDidTap(_ sender: Any) {
    }
    func getCurrentDate()->String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        return result
    }
}
