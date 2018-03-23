//
//  InvoiceViewController.swift
//  Bespokino
//
//  Created by Bespokino on 30/11/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import CoreData
class InvoiceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   

    var data = [Invoice]()
    let invoiceTask = InvoiceTask()
//
//    @IBOutlet weak var addressTextField2: UILabel!
//    @IBOutlet weak var emailTF: UILabel!
//    @IBOutlet weak var nameTextField: UILabel!
//
//
    @IBOutlet weak var subTotalPrice: UILabel!
    @IBOutlet weak var salesTaxPrice: UILabel!
    @IBOutlet weak var totalSalesAmount: UILabel!
    @IBOutlet weak var shipmentPrice: UILabel!
    @IBOutlet weak var paidByCC: UILabel!
    
    
    @IBOutlet weak var invoiceTableView: UITableView!
    @IBOutlet weak var payButton: UIButton!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)

        self.navigationItem.title = "BESPOKINO"
        payButton.layer.cornerRadius = 5
        payButton.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    
        invoiceTask.getInvoiceTask { (success, result, error) in
            
       
            if success{
                self.data = result!
                print(self.data[0].firstName)
                DispatchQueue.main.async {
                    if (self.data.count>0){
                       
                        self.subTotalPrice.text = "$\(String(format: "%.2f",self.data[0].subTotalAmount))"
                        self.salesTaxPrice.text = "$\(String(format: "%.2f",self.data[0].salesTaxAmount))"
                        //self.shipmentPrice.text = "$\(String(format: "%.2f",self.data[0].shippingCost))"
                        self.paidByCC.text = "$\(String(format: "%.2f",self.data[0].paidByCCAmount))"
                        self.totalSalesAmount.text = "$\(String(format: "%.2f",self.data[0].totalSalesAmount))"
                        self.invoiceTableView.reloadData()
                        Payment.ccPay = self.data[0].paidByCCAmount
                    }
                }
                
            }
          
        }
       
     //   getUserInformation()
        self.invoiceTableView.tableFooterView = UIView()

        
        let rightBarButton = UIBarButtonItem(image: UIImage(named:"hme"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.myRightSideBarButtonItemTapped(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
    
    }

    override func viewDidAppear(_ animated: Bool) {
          self.invoiceTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "invoice", for: indexPath)as! InvoiceTableViewCell
        
        print(self.data.count)
        if (self.data.count > 0)
        {
        cell.shirtPrice.text = "$"+String(format: "%.2f",data[indexPath.row].BasicPrice)
        cell.fabricUpgradePrice.text = "$"+String(format: "%.2f",data[indexPath.row].FabricUpgrade)
       // cell.shirtCount.text = "\(data.count) Custom made shirt"
             cell.shirtCount.text = "\(indexPath.row+1). Custom made shirt"
        cell.stylingPrice.text = "$"+String(format: "%.2f",data[indexPath.row].StylingAddup)
        
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    @IBAction func payButtonDidTap(_ sender: Any) {
        

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "BillingViewController") as! BillingViewController
        newViewController.customer = self.data
        newViewController.PAY_TAG = "ANY"
    
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    func getCurrentDate()->String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        return result
    }
    @objc func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        
        self.present(newViewController, animated: true, completion: nil)
        //  self.navigationController?.pushViewController(newViewController, animated: true)
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
    
    
    func getUserInformation()  {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let defaults = UserDefaults.standard
        var userArray:[CustomerInfo] = []
        
        do{
            userArray = try context.fetch(CustomerInfo.fetchRequest())
            print(userArray[0].fullName!)
            print(userArray[0].email!)
            print(userArray[0].customerID)
            print(userArray[0].userId)
         
        }catch{
            
            print(error)
            
        }
    }
}
