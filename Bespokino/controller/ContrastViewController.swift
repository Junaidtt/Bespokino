//
//  ContrastViewController.swift
//  Bespokino
//
//  Created by Bespokino on 11/21/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class ContrastViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
   
    var contrast = [Thread]()
    
 var thread = Thread()
    @IBOutlet weak var contrastCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        self.navigationItem.title = "BESPOKINO"
        thread.fetchContrastFabric { (success, response, error) in
            
            if success{
                
                self.contrast = response as! [Thread]
                if self.contrast.count > 0{
                    
                    self.contrastCollectionView.reloadData()
                    
                }
                
                
                
            }
            
            
        }
        
       self.contrastCollectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return contrast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "contrast", for: indexPath) as? ContrastCollectionViewCell
        
  
        if self.contrast.count > 0{
            
            let threadImage = contrast[indexPath.row].name
            let url = NSURL(string: "http://www.bespokino.com/images/fabric/contrast/"+threadImage!)!

            
            print(url)
            
            cell?.contrastImage.sd_setImage(with: url as URL!, placeholderImage: UIImage(named: "default_logo"), options: .transformAnimatedImage, progress: nil, completed: nil)
            
            
        }
        
        
        return cell!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "contrastHeader", for: indexPath as IndexPath)
        return headerView
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        cell?.layer.borderWidth = 2
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "InnerContrastViewController") as! InnerContrastViewController
        // self.present(newViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(newViewController, animated: true)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell?.layer.borderWidth = 2
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat((collectionView.frame.size.width / 5) - 5), height: CGFloat(110))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    

    
    
    
    
}
