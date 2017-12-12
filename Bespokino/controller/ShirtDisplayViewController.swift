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
class ShirtDisplayViewController: UIViewController {

    @IBOutlet weak var shirtImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var shirtURL:String? = nil
    var shirtType:String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        self.navigationItem.title = "BESPOKINO"
        addButton.layer.cornerRadius = 3.0
        addButton.layer.shadowRadius = 3
        addButton.layer.shadowColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
        addButton.layer.masksToBounds = true
        
        self.typeLabel.text = shirtType
       
        SVProgressHUD.show()
        let url = NSURL(string: shirtURL!)
        
        self.shirtImage.sd_setImage(with: url as URL!, placeholderImage: UIImage(named: ""), options: .transformAnimatedImage, progress: nil, completed: nil)
        
        SVProgressHUD.dismiss()
    
    }
   
  

    @IBAction func addShirtButtonTapped(_ sender: Any) {
        
        

        let s:ShirtDisplay = ShirtDisplay()
        s.getCustomerDetailsTask(completion: { (success, response, error) in
            
            if success{
                
                guard let userDetails = response as? [String:Any]  else {return}
                
                print(userDetails)
               
            }
            
            
        })
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "CollarViewController") as! CollarViewController
        
        self.navigationController?.pushViewController(newViewController, animated: true)
 
 
    }
    
}
