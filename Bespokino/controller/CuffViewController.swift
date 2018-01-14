//
//  CuffViewController.swift
//  Bespokino
//
//  Created by Bespokino on 11/9/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class CuffViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  

    var names = ["1 BUTTON SQUARE","1 BUTTON CURVEDD","1 BUTTON ANGLED","2 BUTTONS SQUARE","2 BUTTONS CURVED","2 BUTTONS ANGLE","FRENCH SQUARED","FRENCH CURVED","FRENCH ANGLED"]
    var value:Int?
    var images = [UIImage]()
    var cuff = [StylingTask]()
    let stylingTask = StylingTask()
    let asynctask = AsyncTask()
    @IBOutlet weak var cuffCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        self.navigationItem.title = "BESPOKINO"

        images = [UIImage(named: "button1square")!,UIImage(named: "button1curved")!,UIImage(named: "button1angled")!,UIImage(named: "button2squared")!,UIImage(named: "buttons2curved")!,UIImage(named: "buttons2angled")!,UIImage(named: "frenchsquared")!,UIImage(named: "frenchcurved")!,UIImage(named: "frenchangled")!]
      
        stylingTask.getCuffData { (result) in
            
            
            print(result)
             self.cuff = result
            if (self.cuff.count>0){
                self.cuffCollectionView.reloadData()

            }
            
            
        }
        
       
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cuff", for: indexPath) as! CuffCollectionViewCell
       
        if self.cuff.count>0{
            cell.cuffLabel.text = cuff[indexPath.row].itemname
            cell.cuffImage.image = cuff[indexPath.row].itemImage
            
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.layer.shadowRadius = 5
            cell.layer.shadowColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        }

        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        let cell1 = collectionView.cellForItem(at: indexPath)
        
        cell1?.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        cell1?.layer.borderWidth = 2
        
        value = cuff[indexPath.row].optionvalue
        
      let cell:CuffCollectionViewCell = collectionView.cellForItem(at: indexPath) as! CuffCollectionViewCell
        if  cell.cuffLabel.text == "FRENCH SQUARED"{
           self.displayAlertMessage(messageToDisplay: " ")
        }else if cell.cuffLabel.text == "FRENCH CURVED"{
           
            self.displayAlertMessage(messageToDisplay: " ")

        }else if cell.cuffLabel.text == "FRENCH ANGLED"{
           
            self.displayAlertMessage(messageToDisplay: " ")

        }else {
            
            stylingTask.cuffInsertionTask(code:value!) { (success, response, error) in
                
                
                if success{
                    
                    guard let result = response as? [String:Any] else{return}
                    
                    print(result)
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "MonogramViewController") as! MonogramViewController
                    
                    self.navigationController?.pushViewController(newViewController, animated: true)
                    
                }
                
                
            }
            
        }
   
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "cuffHeader", for: indexPath as IndexPath)
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((collectionView.frame.size.width / 2) - 5), height: CGFloat(170))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell?.layer.borderWidth = 0
    }
    
    
    func displayAlertMessage(messageToDisplay: String)
    {
        let alertController = UIAlertController(title: "+$10", message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            self.stylingTask.cuffInsertionTask(code: self.value!) { (success, response, error) in
                
                
                if success{
                    
                    guard let result = response as? [String:Any] else{return}
                    
                    print(result)
                    
                
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "MonogramViewController") as! MonogramViewController
                    
                    self.navigationController?.pushViewController(newViewController, animated: true)
                    
                }
                
                
            }
      
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
}
