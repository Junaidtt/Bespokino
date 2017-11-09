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
    
    var images = [UIImage]()
    
    
    @IBOutlet weak var cuffCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.navigationItem.title = "BESPOKINO"
        

        images = [UIImage(named: "button1square")!,UIImage(named: "button1curved")!,UIImage(named: "button1angled")!,UIImage(named: "button2squared")!,UIImage(named: "buttons2curved")!,UIImage(named: "buttons2angled")!,UIImage(named: "frenchsquared")!,UIImage(named: "frenchcurved")!,UIImage(named: "frenchangled")!]
      
    
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cuff", for: indexPath) as! CuffCollectionViewCell
       
        
        cell.cuffLabel.text = names[indexPath.row]
        cell.cuffImage.image = images[indexPath.row]
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.layer.shadowRadius = 5
        cell.layer.shadowColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MonogramViewController") as! MonogramViewController
        
        self.navigationController?.pushViewController(newViewController, animated: true)
        
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
    
}
