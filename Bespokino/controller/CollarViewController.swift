//
//  CollarViewController.swift
//  Bespokino
//
//  Created by Bespokino on 11/8/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class CollarViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
 

    @IBOutlet weak var collarCollectionView: UICollectionView!
    
    var names = ["NORMAL","WIDE SPREAD","ROUND EDGE","BUTTON DOWN","MANDRAIN"]
    
    var images = [UIImage]()
    
    var item = [StylingTask]()
    var collar:StylingTask = StylingTask()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)

        self.navigationItem.title = "BESPOKINO"

        images = [UIImage(named: "Collar_a")!,UIImage(named: "Collar_b")!,UIImage(named: "Collar_c")!,UIImage(named: "Collar_d")!,UIImage(named: "Collar_e")!]

        collar.getCollarData(completion: { (result) in
            
            self.item = result
            
        })
        
        print(Order.customerID)
   
    }

    
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //    return names.count
        
        return item.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collar", for: indexPath) as! CollarCollectionViewCell
       
   
        cell.collarImage.image = item[indexPath.row].itemImage

        
        cell.collarLabel.text = item[indexPath.row].itemname

        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.layer.shadowRadius = 5
        cell.layer.shadowColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        cell.marker.isHidden = true
        
        return cell

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let cell1 = collectionView.cellForItem(at: indexPath)
        cell1?.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        cell1?.layer.borderWidth = 2
        let cell:CollarCollectionViewCell = collectionView.cellForItem(at: indexPath) as! CollarCollectionViewCell
  
        cell.marker.isHidden = false
        cell.marker.image = UIImage(named:"tick")!
      let value = item[indexPath.row].optionvalue
        
       
        
        collar.collarInsertionTask(code: value!) { (success, response, Error) in

            if success {

                guard  let result   =  response as? [String:Any] else {return}

                print(result)

                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

                let newViewController = storyBoard.instantiateViewController(withIdentifier: "CuffViewController") as! CuffViewController
                self.navigationController?.pushViewController(newViewController, animated: true)
            }

        }
    
      
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "collarHeader", for: indexPath as IndexPath)
        return headerView
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((collectionView.frame.size.width / 2) - 5), height: CGFloat(170))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell:CollarCollectionViewCell = collectionView.cellForItem(at: indexPath) as! CollarCollectionViewCell
          cell.marker.isHidden = true
        let cell1 = collectionView.cellForItem(at: indexPath)
        cell1?.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell1?.layer.borderWidth = 2

    }
}
