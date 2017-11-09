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
    let shirtType:String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addButton.layer.cornerRadius = 6
        addButton.layer.shadowRadius = 3
        addButton.layer.shadowColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
       
        SVProgressHUD.show()
        let url = NSURL(string: shirtURL!)
        
        self.shirtImage.sd_setImage(with: url as URL!, placeholderImage: UIImage(named: "white_bg"), options: .transformAnimatedImage, progress: nil, completed: nil)
        
        SVProgressHUD.dismiss()
    
    }
   
  

    @IBAction func addShirtButtonTapped(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "CollarViewController") as! CollarViewController
        
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
}
