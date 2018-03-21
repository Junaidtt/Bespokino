//
//  ShirtDisplayViewController.swift
//  Bespokino
//
//  Created by Bespokino on 11/8/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD
import CoreData
class ShirtDisplayViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIScrollViewDelegate {
   
       let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let data = [String]()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detail", for: indexPath)
        return cell
    }
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var shirtImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var priceTextField: UILabel!
    
    var shirtURL:String? = nil
    var shirtType:String? = nil
    var shirtPrice:String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        scrollview.delegate = self
        self.navigationItem.title = "BESPOKINO"
        addButton.layer.cornerRadius = 3.0
        addButton.layer.shadowRadius = 3
        addButton.layer.shadowColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
        addButton.layer.masksToBounds = true
       self.getCartCount()
        print(shirtType!)

        if self.shirtType == "SHIRT"{
        
        self.typeLabel.text = ""
        }else{
            self.typeLabel.text = shirtType
        }
        
        if shirtType! == "SHIRT"{
           self.priceTextField.text = "$79"
        }else{
            self.priceTextField.text = "+ \(String(describing: shirtPrice!))"

        }
       
        SVProgressHUD.show()
    
        self.shirtImage.sd_setImage(with: URL(string: shirtURL!)) { (image, error, cache, url) in
             SVProgressHUD.dismiss()
        }
        
    getUserInformation()
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return shirtImage
    }
    
    @IBAction func addShirtButtonTapped(_ sender: Any) {

        SVProgressHUD.dismiss()
        let s:ShirtDisplay = ShirtDisplay()
        let defaults = UserDefaults.standard
        let count = defaults.integer(forKey: "CARTCOUNT")
        print(count)
        print(Order.cartCount)
        if Order.cartCount == 0{
            
            
            self.CallgetCustomerDetailsTask()
            
            
        }else{
            
            s.addOnTask(completion: {
                (success, response, error) in
                
                if success {
                    
                    guard let userDetails = response as? [String:Any]  else {return}
                    
                    if userDetails["Error"] as! Bool{
                        let  async = AsyncTask()
                        async.displayAlertMessage(messageToDisplay: "Error")
                    }else{
                        
                        self.CallgetCustomerDetailsTask()
                        
                        

                    }

                }

            })
            
            
        }
   

    }
    
    func CallgetCustomerDetailsTask()  {
       
        let s:ShirtDisplay = ShirtDisplay()
        s.getCustomerDetailsTask(completion: { (success, response, error) in
            
            if success{
                
                guard let userDetails = response as? [String:Any]  else {return}
                
                print(userDetails)
                
                if userDetails["Error"] as! Bool{
                    let  async = AsyncTask()
                    async.displayAlertMessage(messageToDisplay: "Error")
                }else{
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "CollarViewController") as! CollarViewController
                    
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
                
            }
            
            
        })
        
    }
    
    
    func getUserInformation()  {
        
        let defaults = UserDefaults.standard
         var userArray:[CustomerInfo] = []
   
        do{
            userArray = try context.fetch(CustomerInfo.fetchRequest())
            print(userArray[0].fullName!)
           print(userArray[0].email!)
            print(userArray[0].customerID)
            print(userArray[0].userId)
            defaults.set(userArray[0].userId, forKey: "USERID")
            defaults.synchronize()
  
        }catch{
            
            print(error)
            
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
       SVProgressHUD.dismiss()
    }
     func getCartCount(){
        
        let defaults = UserDefaults.standard
        let currentOrderNo = defaults.integer(forKey: "ORDERNO")
        let currentCustomerID = defaults.integer(forKey: "CUSTOMERID")
        guard let url = URL(string: "http://www.bespokino.com/cfc/app.cfc?wsdl&method=listOrderItem&customerID=\(currentCustomerID)&orderNo=\(currentOrderNo)") else {return }
        
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
                    guard let array = json as?[Any] else {return}
                   
                    print(array)
                    print(array.count)
                    defaults.set(array.count, forKey: "CARTCOUNT")
                    
                } catch {
                    print(error)
                }
                
            }
            }.resume()
        
    }
}
