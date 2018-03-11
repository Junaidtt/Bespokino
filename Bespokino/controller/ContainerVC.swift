//
//  ContainerVC.swift
//  Bespokino
//
//  Created by Bespokino on 3/3/2561 BE.
//  Copyright © 2561 bespokinoapp. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {
    @IBOutlet weak var shippingButton: UIButton!
    
    @IBOutlet weak var paymentButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        self.navigationItem.title = "BESPOKINO"
        
        print("started")
 
    }

    @IBAction func paymentButtonDidTap(_ sender: Any) {
        
        print("payment")
        
    }
    @IBAction func shippingDidTap(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
        print("shipping")
        self.dismiss(animated: true, completion: nil)
        
    }
    

}
