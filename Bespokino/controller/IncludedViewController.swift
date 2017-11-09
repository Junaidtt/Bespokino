//
//  IncludedViewController.swift
//  Bespokino
//
//  Created by Bespokino on 11/6/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire
import SDWebImage
import SwiftyJSON

class IncludedViewController: UIViewController,IndicatorInfoProvider,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate {
    
   
    
    var fetchResult = [[String:AnyObject]]()
    var fabric = [Fabric]()
    
    @IBOutlet weak var includedCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Fetch Fabric
        self.populateFabric()

    }

    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        
        return IndicatorInfo(title: "INCLUDED")
        
    }

        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return fabric.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "included", for: indexPath) as! IncludeCollectionViewCell
        
        let imagename = fabric[indexPath.row].fabricImage
        
        let url = NSURL(string: "http://www.bespokino.com/images/fabric/thumb/"+imagename!)!
        print(url)
        
        cell.fabricImage.sd_setImage(with: url as URL!, placeholderImage: UIImage(named: "default_logo"), options: .transformAnimatedImage, progress: nil, completed: nil)

        return cell
        
    }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat((collectionView.frame.size.width / 2) - 5), height: CGFloat(170))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // var cell = collectionView.cellForItem(at: indexPath)
        let url = fabric[indexPath.row].fabricImage
        print("\(String(describing: url!))")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ShirtDisplayViewController") as! ShirtDisplayViewController

        newViewController.shirtURL = "http://www.bespokino.com/images/fabric/"+url!
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
 
    func populateFabric(){
        
        Alamofire.request("http://www.bespokino.com/cfc/app.cfc?wsdl&method=populateFabrics&categoryID=1").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let fabricResult = JSON(responseData.result.value!)
                print(fabricResult)
                
                if let resData = fabricResult.arrayObject {
                    self.fetchResult = resData as! [[String:AnyObject]]
                    
                    print(resData)
                    
                    print(self.fetchResult)
                }
                
                for item in self.fetchResult {
                    
                    print(item)
                    
                    let addUpprice = item["addupPrice"] as! Int
                    let fabricId = item["fabricID"] as! Int
                    let image = item["image"] as! String
                    
                    let f:Fabric = Fabric(image: image , price: addUpprice, code: fabricId)
                    self.fabric.append(f)
                }
            
            }
            if self.fabric.count>0{
                self.includedCollectionView.reloadData()

            }
        }
        
        
    }
    
    

}
