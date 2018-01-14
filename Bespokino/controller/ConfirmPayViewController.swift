//
//  ConfirmPayViewController.swift
//  Bespokino
//
//  Created by Bespokino on 1/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class ConfirmPayViewController: UIViewController {

    @IBOutlet weak var creditCardView: UIView!
    @IBOutlet weak var checkoutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationItem.title = "BESPOKINO"
        checkoutButton.layer.cornerRadius = 5
        checkoutButton.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        creditCardView.layer.shadowRadius = 2
        creditCardView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

    }

 
    
    @IBAction func checkOutButtonDidTap(_ sender: Any) {
        

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "TransactionViewController") as! TransactionViewController
      
        
        self.navigationController?.pushViewController(newViewController, animated: true)

        
        
        
    }
    
   

}
