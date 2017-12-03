//
//  AdditionalOptionsViewController.swift
//  Bespokino
//
//  Created by Bespokino on 11/18/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class AdditionalOptionsViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    var names = ["POCKET","TUXEDO","CONTRAST","BUTTON HOLE & THREAD","WHITE COLLAR & CUFF","PLACKET","BACK PLEAT","SHORT SLEEVE"]
    
    @IBOutlet weak var addOptionCollectionView: UICollectionView!
    var images = [UIImage]()
    var item = [StylingTask]()

    var stylingTask = StylingTask()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        self.navigationItem.title = "BESPOKINO"
        self.addOptionCollectionView?.allowsMultipleSelection = true
        images = [UIImage(named: "pocket")!,UIImage(named: "tuxedo_pleats")!,UIImage(named: "contrast_new")!,UIImage(named: "thread")!,UIImage(named: "whitec")!,UIImage(named: "placketb")!,UIImage(named: "twopleats")!,UIImage(named: "short_sleev")!]
  
        stylingTask.getAddOptiondata { (result) in
            
            
            self.item = result
            
        }
    
        
        
    }

  
 
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "options", for: indexPath) as! AddOptionCollectionViewCell
        
        cell.name.text = item[indexPath.row].itemname
        cell.image.image = item[indexPath.row].itemImage

        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.layer.shadowRadius = 5
        cell.layer.shadowColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
      //  collectionView.reloadData()
        let cell1 = collectionView.cellForItem(at: indexPath)
        cell1?.layer.borderColor  = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        cell1?.layer.borderWidth = 2

        let cell:AddOptionCollectionViewCell = collectionView.cellForItem(at: indexPath) as! AddOptionCollectionViewCell

        print(cell.name.text!)
        
        if   (cell.name.text == "POCKET"){
            print("pocket selected")
            StylingTask.pocket = String(describing: item[indexPath.row].optionvalue)
        }
        else if (cell.name.text == "TUXEDO"){
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "TuxedoViewController") as! TuxedoViewController
           // self.navigationController?.pushViewController(newViewController, animated: true)
            self.present(newViewController, animated: true, completion: nil)

            
        }else if (cell.name.text == "CONTRAST"){
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ContrastViewController") as! ContrastViewController
            // self.present(newViewController, animated: true, completion: nil)
            self.navigationController?.pushViewController(newViewController, animated: true)

            
            
            
        }else if (cell.name.text == "BUTTON HOLE & THREAD"){
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ContrastViewController") as! ContrastViewController
            // self.present(newViewController, animated: true, completion: nil)
            self.navigationController?.pushViewController(newViewController, animated: true)
            
            
            
        }else if (cell.name.text == "WHITE COLLAR & CUFF"){
            
            StylingTask.whiteCuffAndCollar = String(describing: item[indexPath.row].optionvalue)

            
        }else if (cell.name.text == "PLACKET"){
            
        }else if (cell.name.text == "BACK PLEAT"){
            
        }else if (cell.name.text == "SHORT SLEEVE")
        {
            StylingTask.shortSleeve = String(describing: item[indexPath.row].optionvalue)

        }
        
        
        print("cliked")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "addHeader", for: indexPath as IndexPath)
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
    
    
    
}
