//
//  CartViewController.swift
//  Bespokino
//
//  Created by Bespokino on 2/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class CartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var addNewButton: UIButton!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var checkOutButton: UIButton!
    let defaults = UserDefaults.standard

    var cart = [Cart]()
    var cartmodel = CartModel()
    override func viewDidLoad() {
        super.viewDidLoad()

         self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationItem.title = "BESPOKINO"
        addNewButton.layer.cornerRadius = 5
        checkOutButton.layer.cornerRadius = 5
        self.emptyView.isHidden = true
        self.cartTableView.tableFooterView = UIView()
        cartmodel.fetchCartItems { (success, result, error) in
            
            if success{
  
                self.cart = result!
                Order.cartCount = self.cart.count
                if self.cart.count>0{
                  
                    DispatchQueue.main.async {
                        self.cartTableView.reloadData()

                    }
                    
                }
                
            }
          
        }
        
        let yesBody =  defaults.bool(forKey: "YESBODY")
        let measurment = defaults.bool(forKey: "MEASURMENT")
        
        if (yesBody && measurment){
            checkOutButton.setTitle("CHECKOUT", for: .normal)
        }
        
    }

  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cart", for: indexPath) as! CartTableViewCell
        
        if cart.count>0{
            
            //"$"+String(format: "%.2f",cart[indexPath.row].shirtPrice)
            cell.shirtPrice.text = "SHIRT PRICE: $"+String(format: "%.2f",cart[indexPath.row].shirtPrice)
            
            cell.shirtNameCount.text = "SHIRT \(indexPath.row+1)"
            
            print(cart)
            
            let cartImage = cart[indexPath.row].image
            
            print(cartImage)
            
            let url = NSURL(string: "http://www.bespokino.com/images/fabric/"+cartImage)!

            print(url)
            cell.cartImageView.sd_setImage(with:url as URL)

       // cell.cartImageView.sd_setImage(with: url as URL!, placeholderImage: UIImage(named: ""), options: .transformAnimatedImage, progress: nil, completed: nil)
            
        }
       
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let trackingID = cart[indexPath.row].trackingID
    
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController

    
        newViewController.trackingid = trackingID
        newViewController.count = indexPath.row + 1
        
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            print(cart[indexPath.row].trackingID)
            
            cartmodel.deleteCartItemtask(trackingID: cart[indexPath.row].trackingID)

            cart.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    @IBAction func addNewShirtButton(_ sender: Any) {
     
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
         self.present(newViewController, animated: true, completion: nil)
       // self.navigationController?.pushViewController(newViewController, animated: true)
       
        
    }
    
    @IBAction func checkOutButtonDidTap(_ sender: Any) {
        
        
        let yesBody =  defaults.bool(forKey: "YESBODY")
        
        if yesBody{
          
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "FitViewController") as! FitViewController
            // self.present(newViewController, animated: true, completion: nil)
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else{
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "BodyPosturesViewController") as! BodyPosturesViewController
            // self.present(newViewController, animated: true, completion: nil)
            self.navigationController?.pushViewController(newViewController, animated: true)
            
            
        }

       
        
        
    }
    

}
