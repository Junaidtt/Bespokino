//
//  DetailViewController.swift
//  Bespokino
//
//  Created by Bespokino on 29/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import SVProgressHUD
class DetailViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{


    var count:Int?
    var data = [StylingTask]()
    var shirtImg:String = ""
    var trackingid:String = ""
    var TRACKINGID:String = ""
    @IBOutlet weak var shirtCountLabel: UILabel!
    
    @IBOutlet weak var shirtImage: UIImageView!
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationItem.title = "BESPOKINO"
        
        shirtCountLabel.text = "SHIRT \(count!)"
        
        print(trackingid)
        
        self.fetchItemDetail()
    }


    func fetchItemDetail() {
        
        let defaults = UserDefaults.standard
      //  let currentTrackingID = defaults.string(forKey: "TRACKINGID")
        let currentOrderNo = defaults.integer(forKey: "ORDERNO")
        let currentCustomerID = defaults.integer(forKey: "CUSTOMERID")
        let currentPaperNo = defaults.integer(forKey: "PAPERNO")
     
        let endpoint = trackingid
        print(endpoint)
        let tid = endpoint.replacingOccurrences(of: " ", with: "%20")
        print(tid)
        self.TRACKINGID = tid
        
        guard let url = URL(string: "http://www.bespokino.com/cfc/app2.cfc?wsdl&method=getCartListItem&customerID=\(currentCustomerID)&orderNo=\(currentOrderNo)&paperNo=\(currentPaperNo)&trackingID="+tid) else {return}
        
       // let url = URL(string: "http://www.bespokino.com/cfc/app2.cfc?wsdl&method=getCartListItem&customerID=\(Order.customerID)&orderNo=\(Order.orderNo)&paperNo=\(Order.paperNo)&trackingID=\(tid)")
        
        print(url)
        
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
                        
                        guard let detailDic = json as? [String:Any] else{ return }
                        
                        guard let err = detailDic["Error"] as? Bool else {return}
                        
                        print(err)
                        
                        
                        if (!err){
                            
                            guard let collar  = detailDic["collar"] as? Int else {return}
                            guard let shirtImage = detailDic["image"] as? String else {return}
                            guard let cuff  = detailDic["cuff"] as? Int else {return}
                            guard let monogram  = detailDic["monogramStatus"] as? Bool else { return }

                            guard let additionalOption  = detailDic["additionalOptions"] as? Bool else {return}
                            if (additionalOption){
                                self.getAddOption()
                                self.fetchAddOptionDetail()
                            }
                            if monogram{
                                self.getMonogram()
                            }
                            self.shirtImg = shirtImage
                            print(cuff)
                            print(collar)
                            print(monogram)
                            self.getCollar(optionValue: collar)
                            self.getCuff(optionValue: cuff)
    
                        }

                        DispatchQueue.main.async {
                            
                            self.detailCollectionView.reloadData()

                            let shirtURL = "http://www.bespokino.com/images/fabric/\(self.shirtImg)"
                            
                            SVProgressHUD.show()
                           // let url = URL(string: shirtURL)
    
                            self.shirtImage.sd_setImage(with: URL(string: shirtURL)) { (image, error, cache, url) in
                                SVProgressHUD.dismiss()
                            }
                            
                        }
                        
                    } catch {
                        print(error)
                    }
                    
                }
                }.resume()

    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detail", for: indexPath) as? DetailCollectionViewCell
        
        cell?.detailItemImage.image = data[indexPath.row].itemImage
        cell?.detailItemLabel.text = data[indexPath.row].itemname?.uppercased()
       // cell?.detailItemLabel.text?.capitalized
        
        cell?.layer.borderWidth = 0.5
        cell?.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((collectionView.frame.size.width / 3) ), height: CGFloat(130))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(data[indexPath.row].itemname!)
        if data[indexPath.row].itemname! == "Monogram"{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "MonoDetailViewController") as! MonoDetailViewController
            newViewController.trackid = self.TRACKINGID
            self.navigationController?.pushViewController(newViewController, animated: true)
            
        }else if data[indexPath.row].itemname! == "Additional Options"{
            
            
            
            
            
        }
        
    }
    func getCollar(optionValue:Int) {
        
        var item = [StylingTask]()
        
        let collar1 = StylingTask(name: "NORMAL", image: UIImage(named: "Collar_a")!, optionVal: 191)
        let collar2 = StylingTask(name: "WIDE SPREAD", image: UIImage(named: "Collar_b")!, optionVal: 192)
        let collar3 = StylingTask(name: "ROUND EDGE", image: UIImage(named: "Collar_c")!, optionVal: 193)
        let collar4 = StylingTask(name: "BUTTON DOWN", image: UIImage(named: "Collar_d")!, optionVal: 194)
        let collar5 = StylingTask(name: "MANDARIN", image: UIImage(named: "Collar_e")!, optionVal: 195)
   
        item.append(collar1)
        item.append(collar2)
        item.append(collar3)
        item.append(collar4)
        item.append(collar5)
        
        for i in item{
            
            if i.optionvalue! == optionValue{
                self.data.append(i)
            }
            
        }

    }
    func getCuff(optionValue:Int) {
        
        
        var item = [StylingTask]()
        
        let cuff1 = StylingTask(name: "1 BUTTON SQUARE", image:UIImage(named: "button1square")!, optionVal: 200)
        let cuff2 = StylingTask(name: "1 BUTTON CURVEDD", image:UIImage(named: "button1curved")!, optionVal: 201)
        let cuff3 = StylingTask(name: "1 BUTTON ANGLED", image:UIImage(named: "button1angled")!, optionVal: 531)
        
        let cuff4 = StylingTask(name: "2 BUTTONS SQUARE", image:UIImage(named: "button2squared")!, optionVal: 202)
        let cuff5 = StylingTask(name: "2 BUTTONS CURVED", image:UIImage(named: "buttons2curved")!, optionVal: 532)
        let cuff6 = StylingTask(name: "2 BUTTONS ANGLE", image:UIImage(named: "buttons2angled")!, optionVal: 203)
        
        let cuff7 = StylingTask(name: "FRENCH SQUARED", image:UIImage(named: "frenchsquared")!, optionVal: 533)
        let cuff8 = StylingTask(name: "FRENCH CURVED", image:UIImage(named: "frenchcurved")!, optionVal: 359)
        let cuff9 = StylingTask(name: "FRENCH ANGLED", image:UIImage(named: "frenchangled")!, optionVal: 358)
        
        
        item.append(cuff1)
        item.append(cuff2)
        item.append(cuff3)
        item.append(cuff4)
        item.append(cuff5)
        item.append(cuff6)
        item.append(cuff7)
        item.append(cuff8)
        item.append(cuff9)

        
        for i in item{
            
            if i.optionvalue! == optionValue{
                self.data.append(i)
            }
            
        }

    }
    
    func getMonogram()  {
        
        self.data.append(StylingTask(name: "Monogram", image: UIImage(named: "monogram_body")!, optionVal: 1))

    }
    
    func getAddOption()  {
        
       // self.data.append(StylingTask(name: "Additional Options", image: UIImage(named: "placket")!, optionVal: 1))
        
    }
    
    func fetchAddOptionDetail(){
        
        let defaults = UserDefaults.standard
       // let currentTrackingID = defaults.string(forKey: "TRACKINGID")
        let currentOrderNo = defaults.integer(forKey: "ORDERNO")
        let currentCustomerID = defaults.integer(forKey: "CUSTOMERID")
        let currentPaperNo = defaults.integer(forKey: "PAPERNO")
        
        guard let url = URL(string: "http://www.bespokino.com/cfc/app2.cfc?wsdl&method=getAdditionalOptionsInfo&customerID=\(currentCustomerID)%20&orderNo=\(currentOrderNo)%20&paperNo=\(currentPaperNo)&trackingID=\(self.TRACKINGID)") else { return }
        
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
                    
                    guard let addOptionDic = json as? [String:Any] else {return}
                    
                    guard let whiteCuffAndCollar = addOptionDic["whiteCuffAndCollar"] as? Double else {return}
                    
                    guard let pocket = addOptionDic["pocket"] as? Double else {return}
                    
                    guard let collarFabricContrast = addOptionDic["collarFabricContrast"] as? Double else {return}
                    
                    guard let cuffFabricContrast = addOptionDic["cuffFabricContrast"] as? Double else {return}
                    
                    guard let placketFabricContrast = addOptionDic["placketFabricContrast"] as? Double else {return}
                    
                      guard let placket = addOptionDic["placket"] as? Double else {return}
                    
                     guard let shortSleeve = addOptionDic["shortSleeve"] as? Double else {return}
                    
                      guard let backPleats = addOptionDic["backPleats"] as? Double else {return}
                    
                    //   guard let buttonholeThreadColor = addOptionDic["buttonholeThreadColor"] as? Double else {return}
                    
                    if shortSleeve == 208 {
                        
                        self.data.append(StylingTask(name: "SHORT SLEEVE", image: UIImage(named: "short_sleev")!, optionVal: 208))
                        
                        DispatchQueue.main.async {
                            
                            self.detailCollectionView.reloadData()
                        }
                    }
                    
                    if backPleats == 156{
                        self.data.append(StylingTask(name: "NO PLEATS", image: UIImage(named: "nopleats")!, optionVal: 156))

                        DispatchQueue.main.async {
                            
                            self.detailCollectionView.reloadData()
                        }
                        
                    }else if backPleats == 157{
                        self.data.append(StylingTask(name: "ONE PlEAT", image: UIImage(named: "onepleats")!, optionVal: 157))
                        DispatchQueue.main.async {
                            
                            self.detailCollectionView.reloadData()
                        }
                        
                        
                    }else if backPleats == 158{
                        self.data.append(StylingTask(name: "TWO PLEATS", image: UIImage(named: "twopleats")!, optionVal: 158))

                        DispatchQueue.main.async {
                            
                            self.detailCollectionView.reloadData()
                        }

                    }

                    if placket  == 159{
                        self.data.append(StylingTask(name: "NO PLACKET", image: UIImage(named: "noplacket")!, optionVal: 159))
                        
                        DispatchQueue.main.async {
                            
                            self.detailCollectionView.reloadData()
                        }
                    }else if placket == 160{
                             self.data.append(StylingTask(name: "PLACKET", image: UIImage(named: "placket_yes")!, optionVal: 160))
                        
                        
                        DispatchQueue.main.async {
                            
                            self.detailCollectionView.reloadData()
                        }
                    }else if placket == 161{
                        
                        self.data.append(StylingTask(name: "HIDDEN PLACKET", image: UIImage(named: "hiddenplacketc")!, optionVal: 161))

                        DispatchQueue.main.async {
                            
                            self.detailCollectionView.reloadData()
                        }
                        
                    }
       
                    if pocket == 187{
                        
                        // let addOptiom2 = StylingTask(name: "TUXEDO", image: UIImage(named: "tuxedo_pleats")!, optionVal: 528)
                        
                        
                        self.data.append(StylingTask(name: "POCKET", image: UIImage(named: "pocket")!, optionVal: 187))
                        
                        DispatchQueue.main.async {
                            
                            self.detailCollectionView.reloadData()
                        }
                        
                    }
                    guard let tuxedo = addOptionDic["tuxedo"] as? Double else {return}
                    
                    guard let sleeveVentFabricContrast = addOptionDic["sleeveVentFabricContrast"] as? Double else {return}
                    
                    print(tuxedo)
                    print(sleeveVentFabricContrast)
                    print(whiteCuffAndCollar)
                    
                    if sleeveVentFabricContrast == 148 {
                        
                        self.data.append(StylingTask(name: "SLEEVE VENT CONTRAST", image: UIImage(named: "sleeve_vent")!, optionVal: 528))

                        DispatchQueue.main.async {
                            
                            self.detailCollectionView.reloadData()
                        }
                        
                    }
                    
                    
                    if tuxedo == 528{
                        
                        self.data.append(StylingTask(name: "TEXEDO", image: UIImage(named: "tuxedo_pleats")!, optionVal: 528))
                        
                        DispatchQueue.main.async {
                            
                            self.detailCollectionView.reloadData()
                        }
                        
                        
                        
                    }else if tuxedo == 527{
                        
                        self.data.append(StylingTask(name: "TEXEDO", image: UIImage(named: "yes_tuxedo_pleats")!, optionVal: 527))
                        
                        DispatchQueue.main.async {
                            
                            self.detailCollectionView.reloadData()
                        }
                        
                        
                        
                    }
 
                    if whiteCuffAndCollar == 206{
                        
                        
                        self.data.append(StylingTask(name: "WHITE COLLAR & CUFF", image: UIImage(named: "whitec")!, optionVal: 206))

                        DispatchQueue.main.async {
                            
                            self.detailCollectionView.reloadData()
                        }
                        
                    }
                    
                    
                    if  collarFabricContrast == 547{
                        
                        self.data.append(StylingTask(name: "INNER COLLAR", image: UIImage(named: "inner_c")!, optionVal: 547))
                        
                        DispatchQueue.main.async {
                            
                            self.detailCollectionView.reloadData()
                        }
                    }
                    
                    
                    if cuffFabricContrast == 549 {
                        
                        self.data.append(StylingTask(name: "INNER CUFF", image: UIImage(named: "inner_cuff")!, optionVal: 549))
                        
                        DispatchQueue.main.async {
                            
                            self.detailCollectionView.reloadData()
                        }
                    }
                    
                    if placketFabricContrast == 150{
                        
                        self.data.append(StylingTask(name: "INNER PLACKET", image: UIImage(named: "inner_placket")!, optionVal: 150))
                        
                        DispatchQueue.main.async {
                            
                            self.detailCollectionView.reloadData()
                        }
                    }
                    
                    
          
                } catch {
                    print(error)
                }
                
            }
            }.resume()
        
    }
    
    
    
}
