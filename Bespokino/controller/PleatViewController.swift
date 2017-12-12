//
//  PleatViewController.swift
//  Bespokino
//
//  Created by Bespokino on 5/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class PleatViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    var pleats = ["NO PLEAT","ONE PLEAT","TWO PLEAT"]
    let optionValue = ["156","157","158"]

    var image:[UIImage] = [
        UIImage(named: "nopleats")!,
        UIImage(named: "onepleats")!,
        UIImage(named: "twopleats")!
    ]
    @IBOutlet weak var pleatCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        self.navigationItem.title = "BESPOKINO"
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pleats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pleat", for: indexPath) as! PleatCollectionViewCell
        
        cell.pleatlabel.text = pleats[indexPath.row]
        
        cell.pleatImage.image = image[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        cell?.layer.borderWidth = 2
        
        StylingTask.backpleats = optionValue[indexPath.row]
        AdditionalOptions.backpleats = optionValue[indexPath.row]


        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "pleatsHeader", for: indexPath as IndexPath)
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat((collectionView.frame.size.width / 2) - 5), height: CGFloat(170))
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell?.layer.borderWidth = 2
    }
    
    
    @IBAction func saveButtonDIdTap(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
}
