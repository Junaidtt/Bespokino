//
//  MeasurmentParentViewController.swift
//  Bespokino
//
//  Created by Bespokino on 6/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import CoreData

protocol MyDelegate {
    func selectChildControllerAtIndex(toIndex: Int!)
    func selectViewController(viewController: UIViewController)
}

struct Control {
    
    static var pointer:Int? = nil
    
}

class MeasurmentParentViewController: ButtonBarPagerTabStripViewController {

    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var model:String?
    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
       // self.navigationItem.title = "BESPOKINO"
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Model")
        
        do{
            let result = try context.fetch(request)
            
            if result.count>0{
                
                self.model = (result[0] as AnyObject).value(forKey: "modelNumber") as? String
                
            }

        }catch{
            print(error.localizedDescription)
        }
    
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
        super.viewDidAppear(true)
        
        
      //  containerView.isScrollEnabled = false
        
        
        
//        if UserDefaults.standard.object(forKey: "check") != nil{
//
//            let check =  UserDefaults.standard.object(forKey: "check") as! Int
//            if check == 1{
//                moveToViewControllerAtIndex(check)
//               // moveToViewcontroller(at: 1)
//            }
//
//
//        }
  
        
//                    if Control.pointer != nil{
//
//                       self.moveToViewControllerAtIndex(Control.pointer!)
//
//                    }
    }
    
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let sleeve = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SleeveViewController")
        let shoulder = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShoulderMeasureViewController")
          let chest = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChestViewController")
         let waist = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WaistViewController")
        
        let hips = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HipsViewController")
        
           let biceps = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BicepsViewController")
        let neck = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NeckViewController")
        
        let cuff = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CuffMeasurmentViewController")

                let length = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LengthViewController")
        return [shoulder,sleeve,chest,waist,hips,biceps,neck,cuff,length]
    }
   
//    func moveToViewcontroller(at index: Int){
//
//        print("\(index)")
//
//
//            if Control.pointer != nil{
//
//               self.moveToViewControllerAtIndex(Control.pointer!)
//
//            }
//
//    }

    

}
