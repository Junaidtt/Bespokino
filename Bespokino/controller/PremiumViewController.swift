//
//  PremiumViewController.swift
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
class PremiumViewController: UIViewController,IndicatorInfoProvider,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var premiumCollectionView: UICollectionView!
    
    
    var fetchResult = [[String:AnyObject]]()
    var fabric = [Fabric]()
    override func viewDidLoad() {
        super.viewDidLoad()

        populateFabric()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "PREMIUM")
    }
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fabric.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "premium", for: indexPath) as! PremiumCollectionViewCell
        
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
    
    func populateFabric(){
        
        Alamofire.request("http://www.bespokino.com/cfc/app.cfc?wsdl&method=populateFabrics&categoryID=2").responseJSON { (responseData) -> Void in
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
                self.premiumCollectionView.reloadData()
                
            }
        }
        
        
    }
    
    
}