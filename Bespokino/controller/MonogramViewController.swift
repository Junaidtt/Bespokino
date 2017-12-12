//
//  MonogramViewController.swift
//  Bespokino
//
//  Created by Bespokino on 11/9/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class MonogramViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    @IBOutlet weak var iamOnLowKey: UIButton!
    @IBOutlet weak var monogramCollectionView: UICollectionView!
    
    var name = ["POCKET","CUFF","BACK OF COLLAR","INSIDE COLLAR","BODY"]
    var optionValue = ["172","171","174","173","170"]
    var images = [UIImage]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        iamOnLowKey.layer.cornerRadius  =  6
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        self.navigationItem.title = "BESPOKINO"
        
        images = [UIImage(named: "monogram_pocket")!,UIImage(named: "monogram_cuff")!,UIImage(named: "monogram_back_collar")!,UIImage(named: "monogram_inside_collar")!,UIImage(named: "monogram_body")!]
        
       
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return name.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
      
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mono", for: indexPath) as! MonogramCollectionViewCell
        cell.monogramLabel.text = name[indexPath.row]
        cell.monogramImage.image = images[indexPath.row]
        
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.layer.shadowRadius = 5
        cell.layer.shadowColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        cell?.layer.borderWidth = 2
        
    
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MonogramPadViewController") as! MonogramPadViewController
        newViewController.positionSelected = optionValue[indexPath.row]
        self.navigationController?.pushViewController(newViewController, animated: true)
        
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "monoHeader", for: indexPath as IndexPath)
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
    
    @IBAction func iamOnLowKeyDidTap(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AdditionalOptionsViewController") as! AdditionalOptionsViewController
        // self.present(newViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    
}
