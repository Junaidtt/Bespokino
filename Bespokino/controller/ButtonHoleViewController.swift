//
//  ButtonHoleViewController.swift
//  Bespokino
//
//  Created by Bespokino on 4/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class ButtonHoleViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
  
    @IBOutlet weak var buttonCollectionView: UICollectionView!
    
    let color = Thread()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        self.navigationItem.title = "BESPOKINO"
        
        print(ThreadCode.selectedThreadCode)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if ThreadCode.selectedIndex != nil{
            let indexPathForFirstRow = IndexPath(row: ThreadCode.selectedIndex!, section: 0)
            self.buttonCollectionView?.selectItem(at: indexPathForFirstRow, animated: true, scrollPosition: .top)
            
            let cell = self.buttonCollectionView.cellForItem(at: indexPathForFirstRow)
            
            cell?.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
            cell?.layer.borderWidth = 2
        }
      
    }

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return color.menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hole", for: indexPath) as! ButtonCollectionViewCell
        
        let item = color.menuItems[indexPath.row]
        print(item)
        let img = UIImage(named:item["Image"]!)
        
        cell.holeImage.image = img
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        let item = color.menuItems[indexPath.row]

        StylingTask.buttonholeColor = item["code"]!
        AdditionalOptions.buttonholeColor = item["code"]!

        cell?.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        cell?.layer.borderWidth = 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell?.layer.borderWidth = 2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat((collectionView.frame.size.width / 5) - 5), height: CGFloat(80))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    @IBAction func closeButtonDidTap(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonDidtap(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
        
        
        
    }
    
}
