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
        //let url = NSURL(string: shirtURL!)
        
       // self.shirtImage.sd_setImage(with: url as URL!, placeholderImage: UIImage(named: ""), options: .transformAnimatedImage, progress: nil, completed: nil)
        
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
                        
                        
//                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "CollarViewController") as! CollarViewController
//                        
//                        self.navigationController?.pushViewController(newViewController, animated: true)
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
            defaults.set(userArray[0].userId, forKey: "USERID")
            defaults.synchronize()
            
            
            
        }catch{
            
            print(error)
            
        }
    }

}
