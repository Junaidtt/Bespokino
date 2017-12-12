//
//  PlacketCollectionViewController.swift
//  Bespokino
//
//  Created by Bespokino on 5/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class PlacketCollectionViewController:UIViewController ,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
  
    
   
    @IBOutlet weak var placketCollectionView: UICollectionView!
    
    let optionValue = ["160","159","161"]
    var placket = ["PLACKET","NO PLACKET","HIDDEN PLACKET"]
    var image:[UIImage] = [
        UIImage(named: "noplacket")!,
        UIImage(named: "placket_yes")!,
        UIImage(named: "hiddenplacketc")!
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        self.placketCollectionView.allowsMultipleSelection = false
        self.navigationItem.title = "BESPOKINO"
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placket.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "placket", for: indexPath) as! PlacketCollectionViewCell
        
        cell.placketLabel.text = placket[indexPath.row]
        cell.placketImage.image = image[indexPath.row]
        
        StylingTask.placket = optionValue[indexPath.row]
        AdditionalOptions.placket = optionValue[indexPath.row]

        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)        
        cell?.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        cell?.layer.borderWidth = 2
        StylingTask.placket = ""
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "placketHeader", for: indexPath as IndexPath)
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
    
    
    
    @IBAction func saveButtonDidTap(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
}
