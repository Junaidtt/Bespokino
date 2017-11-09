//
//  MenuViewController.swift
//  Bespokino
//
//  Created by Bespokino on 11/10/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var menuTableView: UITableView!
    
    
    var menu = ["HOME","ABOUT US","PENDING ORDER","MEASURING TOOL"]
    
    var picture:[UIImage] = [
        UIImage(named: "home")!,
        UIImage(named: "info")!,
         UIImage(named: "ordering")!,
        UIImage(named: "measure")!
       ]
 

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuTableViewCell
        
        cell.menulabel.text = menu[indexPath.row]
        
        cell.menuImage.image = picture[indexPath.row]
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(40)
    }
    
}