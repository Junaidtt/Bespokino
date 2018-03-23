//
//  ParentViewController.swift
//  Bespokino
//
//  Created by Bespokino on 11/6/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ParentViewController: ButtonBarPagerTabStripViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    var badgeCount = Int()
    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        self.navigationItem.title = "BESPOKINO"
        
        if self.revealViewController() != nil {
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            
        }
        
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        
        
        self.edgesForExtendedLayout = []
        self.navigationItem.title = "BESPOKINO"
        
        
        // change selected bar color
        settings.style.buttonBarBackgroundColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        settings.style.buttonBarItemBackgroundColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        settings.style.selectedBarBackgroundColor = purpleInspireColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = self?.purpleInspireColor
        }
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
     
        
        // Call To Method
        
        self.badgeCount = Order.cartCount
        self.setUpBadgeCountAndBarButton()
        
        
        
    }
  
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let included = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IncludedViewController")
        let premium = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PremiumViewController")
        let luxury = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LuxuryViewController")
        return [included,premium,luxury]
    }
  
    
    @IBAction func cartButtonDidTap(_ sender: Any) {
        
        if Order.cartCount > 0 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
 
        
    }
    
    // Instance Method
    
    func setUpBadgeCountAndBarButton() {
        // badge label
        
      let label = UILabel(frame: CGRect(x: 10, y: -05, width: 20, height: 20))
        if self.badgeCount > 0{
            
         
            label.layer.borderColor = UIColor.clear.cgColor
            label.layer.borderWidth = 2
            label.layer.cornerRadius = label.bounds.size.height / 2
            label.textAlignment = .center
            label.layer.masksToBounds = true
            label.textColor = .white
            label.font = label.font.withSize(12)
            label.backgroundColor = .red
            label.text = "\(self.badgeCount)"
        }
        
        
        // button
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        rightButton.setBackgroundImage(UIImage(named: "cart-icon"), for: .normal)
        rightButton.addTarget(self, action: #selector(myRightSideBarButtonItemTapped), for: .touchUpInside)
        rightButton.addSubview(label)
        
        // Bar button item
        let rightBarButtomItem = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = rightBarButtomItem
    }
    @objc func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
    {
        
        if Order.cartCount > 0{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
            
            
            //  self.present(newViewController, animated: true, completion: nil)
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
     
    }
}
