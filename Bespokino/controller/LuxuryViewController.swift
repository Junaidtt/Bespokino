//
//  LuxuryViewController.swift
//  Bespokino
//
//  Created by Bespokino on 11/6/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SDWebImage
import SVProgressHUD
class LuxuryViewController: UIViewController,IndicatorInfoProvider,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    @IBOutlet weak var luxuryCollectionView: UICollectionView!
    
    
    var fetchResult = [[String:AnyObject]]()
    var fabric = [Fabric]()
    override func viewDidLoad() {
        super.viewDidLoad()

        SVProgressHUD.show()
        self.popoulateFabricData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "LUXURY")

    }
    

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fabric.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "luxury", for: indexPath) as! LuxuryCollectionViewCell
        
        let imagename = fabric[indexPath.row].fabricImage
        
        let url = NSURL(string: "http://www.bespokino.com/images/fabric/thumb/"+imagename!)!
        print(url)
        
        cell.fabricImage.sd_setImage(with: url as URL!, placeholderImage: UIImage(named: "default_logo"), options: .transformAnimatedImage, progress: nil, completed: nil)
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((collectionView.frame.size.width / 2) - 5), height: CGFloat(160))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // var cell = collectionView.cellForItem(at: indexPath)
        let url = fabric[indexPath.row].fabricImage
        print("\(String(describing: url!))")
        Order.fabid = String(describing: fabric[indexPath.row].fabricCode!)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ShirtDisplayViewController") as! ShirtDisplayViewController
        newViewController.shirtType = "LUXURY"
        newViewController.shirtPrice = "$40"
        newViewController.shirtURL = "http://www.bespokino.com/images/fabric/"+url!
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    
    
    
    func popoulateFabricData() {
        
        
        guard let url = URL(string: "http://www.bespokino.com/cfc/app.cfc?wsdl&method=populateFabrics&categoryID=3") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                print(data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    SVProgressHUD.dismiss()
                    
                    guard  let fabricArr = json as?[Any] else {return}
                    
                    for fabric in fabricArr{
                        guard let dic = fabric as?[String:Any] else {return}
                        guard let addUpprice = dic["addupPrice"] as? Int else {return}
                        guard let fabricId = dic["fabricID"] as? Int else {return}
                        
                        guard let image = dic["image"] as? String else {return}
                        
                        let f:Fabric = Fabric(image: image , price: addUpprice, code: fabricId)
                        self.fabric.append(f)
                        
                    }
                    
                    DispatchQueue.main.async {
                        
                        
                        if self.fabric.count>0{
                            self.luxuryCollectionView.reloadData()

                        }
                        
                        
                    }
                    
                } catch {
                    print(error)
                }
                
            }
            }.resume()
        
        
    }
    
}
