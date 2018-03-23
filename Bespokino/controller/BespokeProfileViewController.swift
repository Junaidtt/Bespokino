//
//  BespokeProfileViewController.swift
//  Bespokino
//
//  Created by Bespokino on 16/3/2561 BE.
//  Copyright © 2561 bespokinoapp. All rights reserved.
//

import UIKit

class BespokeProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    struct Objects {
        
       var sectionNames:String!
       var sectionObjects:[String]!
        var itemName:[String]!
        
        
        
    }
  
    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    var objectsArray = [Objects]()
    
    @IBOutlet weak var bespokeTB: UITableView!
    let defaults = UserDefaults.standard
    let array = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
           self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationItem.title = "BESPOKINO"

        if self.revealViewController() != nil {
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        btnMenuButton.target = revealViewController()
        btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
    
        self.bespokeTB.tableFooterView = UIView()

     
        let userid = defaults.string(forKey: "USERID")
    
        if (!userid!.isEmpty){
      
            self.fetchMeasurments(userid: userid!)
        }
       
        let rightBarButton = UIBarButtonItem(title: "Update", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.myRightSideBarButtonItemTapped(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
    
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return objectsArray[section].sectionObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "bespokeProfile", for: indexPath) as? BespokeProfileTableViewCell
        
        cell?.itemImage.image = UIImage(named:objectsArray[indexPath.section].sectionObjects[indexPath.row])
        cell?.itemName.text = objectsArray[indexPath.section].itemName[indexPath.row]
      //  cell.textLabel?.text = objectsArray[indexPath.section].sectionObjects[indexPath.row]
        
        if objectsArray[indexPath.section].sectionNames == "BESPOKE MEASURMENT"{
            
            cell?.itemImage.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        cell?.itemImage.layer.borderWidth = 0.5
        cell?.itemImage.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        return cell!
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectsArray.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return objectsArray[section].sectionNames
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).backgroundView?.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
    }
    
    @objc func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
    {

        

        
        let alertController = UIAlertController(title: "Update", message: "Update your Bespoke Profile", preferredStyle: .actionSheet)
        
        let sendButton = UIAlertAction(title: "Body Posture", style: .default, handler: { (action) -> Void in
            print("Body Posture")
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "BodyPosturesViewController") as! BodyPosturesViewController

                    self.navigationController?.pushViewController(newViewController, animated: true)
        })
        
        let  deleteButton = UIAlertAction(title: "Bespoke Measurment", style: .default, handler: { (action) -> Void in
            print("Measurment button tapped")
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "MeasurmentParentViewController") as! MeasurmentParentViewController
            
            self.navigationController?.pushViewController(newViewController, animated: true)
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        
        alertController.addAction(sendButton)
        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        
        self.navigationController!.present(alertController, animated: true, completion: nil)
        
    }
    
 
    func fetchGetBodyPosture(userid:String!){
        
     
        guard let url = URL(string: "http://www.bespokino.com/cfc/app.cfc?wsdl&method=getBodyPostureInfo&userID=\(userid!)") else { return }
        
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
                    
                    guard let result = json as? [String:Any] else {return}
                    guard let posture = result["posture"] as? String else { return }
                    guard let shoulders = result["shoulders"] as? String else { return }
                    guard let pelvis = result["pelvis"] as? String else { return }
                    guard let chest = result["chest"] as? String else { return }
                    guard let abdomen = result["abdomen"] as? String else { return }
                    
                   //self.objectsArray.append(Objects(sectionNames: "BODY POSTURE", sectionObjects: [posture,shoulders,chest,abdomen,pelvis]))
                  
                    print(posture.isEmpty)
                  
                    if (posture.isEmpty){
                        DispatchQueue.main.async {
                            self.bespokeTB.isHidden = true
                        }
                    }else{
                        
                        self.objectsArray.append(Objects(sectionNames: "BODY POSTURE", sectionObjects: [posture,shoulders,chest,abdomen,pelvis], itemName: ["POSTURE","SHOULDER","CHEST","ABOMEN","PELVIS"]))
                        
                          // self.fetchMeasurments(userid: userid!)
                        
                        DispatchQueue.main.async {
                             self.bespokeTB.isHidden = false
                            self.bespokeTB.reloadData()
                           
                        }
                      
                    }
            
                   
                    
                    
                } catch {
                    print(error)
                }
                
            }
            }.resume()
        
        
    }
    
    func fetchMeasurments(userid:String!){
        
        var neck:String?
        var shoulder:String?
        var biceps:String?
        var cuff:String?
        var length:String?
        var waist:String?
        var hips:String?
        var sleeve:String?
        var chest:String?
        print(userid)
        
        guard let url = URL(string: "http://www.bespokino.com/cfc/app.cfc?wsdl&method=getMeasurementAdjustmentInfo&userID=\(Int(userid)!)") else { return }
        
      //  guard let url = URL(string: "http://www.bespokino.com/cfc/app.cfc?wsdl&method=getMeasurementAdjustmentInfo&userID=51015") else { return }
        
        
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
                  
                    
                    guard let resultDic = json as? [String:Any] else {return}
                    
                 // guard let Sleeve_Adjustment = resultDic["Sleeve_Adjustment"] as? Int else {return}

                    guard let pantsWaist = resultDic["pantsWaist"] as? Int else {return}
                    guard let modelNo = resultDic["modelNo"] as? Int else {return}
                    self.defaults.set(modelNo, forKey: "MODELNO")

                    print(pantsWaist)
                    print(modelNo)
                    self.objectsArray.append(Objects(sectionNames: "PANT WAIST SIZE", sectionObjects: ["pants"], itemName: ["PANT WAIST SIZE - \(pantsWaist)"]))
                    
                    self.objectsArray.append(Objects(sectionNames: "MODEL NUMBER", sectionObjects: ["cuff_guide"], itemName: ["MODEL NUMBER - \(modelNo)"]))

                    guard let neckMeasurment = resultDic["Neck_Adjustment"] as? Double else {return}
                  
                    print(neckMeasurment)
                    guard let shoulderMeasurment = resultDic["Shoulder_Adjustment"] as? Double else {return}
                    print(shoulderMeasurment)
                    guard let sleeveMeasurment = resultDic["Sleeve_Adjustment"] as? Double else {return}
                    print(sleeveMeasurment)
                    guard let chestMeasurment = resultDic["Chest_Adjustment"] as? Double else {return}

                    print(chestMeasurment)
                    guard let hipsMeasurment = resultDic["Hips_Adjustment"] as? Double else {return}
                    print(hipsMeasurment)
                    guard let waistMeasurment = resultDic["Waist_Adjustment"] as? Double else {return}

                    print(waistMeasurment)
                    guard let bicepsMeasurment = resultDic["Biceps_Adjustment"] as? Double else {return}
                    print(bicepsMeasurment)
                    guard let cuffMeasurment = resultDic["Cuff_Adjustment"] as? Double else {return}
                    print(cuffMeasurment)
                    guard let lengthMeasurment = resultDic["Length_Adjustment"] as? Double else {return}

                    print(lengthMeasurment)
                
    //length
                    
                    if lengthMeasurment == 0{
                        length = "Length_isgood"
                    }else if lengthMeasurment == -1.0{
                        length = "red-line"
                    }else if lengthMeasurment == -2.0{
                        length = "yellow-line"
                    }else if lengthMeasurment == -3.0{
                        length = "green-line"
                    }else if lengthMeasurment == -4.0{
                        length = "blue-line"
                    }else if lengthMeasurment == 1.0{
                        length = "oneinch"
                    }else if lengthMeasurment == 2.0{
                        length = "twoinch"
                        
                    }
                 
      //cuff
            
                    if cuffMeasurment == 0{
                        
                        if (modelNo >= 9){
                            cuff = "cuff9_1"
                        }else if (modelNo < 9){
                               cuff = "cuff8_1"
                        }
                        
                        
                    }else if cuffMeasurment == -1{
                        
                        if (modelNo >= 9){
                            cuff = "cuff9_2"
                        }else if (modelNo < 9){
                            cuff = "cuff8_2"
                        }
                        
                    }else if cuffMeasurment == -2{
                        
                        if (modelNo >= 9){
                            cuff = "cuff9_3"
                        }else if (modelNo < 9){
                            cuff = "cuff8_3"
                        }
                    }else if cuffMeasurment == -3{
                        
                        if (modelNo >= 9){
                            cuff = "cuff9_4"
                        }else if (modelNo < 9){
                            cuff = "cuff8_4"
                        }
                        
                    }else if cuffMeasurment == -4{
                        
                        if (modelNo >= 9){
                            cuff = "cuff9_5"
                        }else if (modelNo < 9){
                            cuff = "cuff8_5"
                        }
                        
                    }else if cuffMeasurment == -5{
                        
                        if (modelNo >= 9){
                            cuff = "cuff9_6"
                        }else if (modelNo < 9){
                            cuff = "cuff8_6"
                        }
                        
                    }else if cuffMeasurment == -6{
                        
                        if (modelNo >= 9){
                            cuff = "cuff9_7"
                        }else if (modelNo < 9){
                            cuff = "cuff8_7"
                        }
                        
                    }else if cuffMeasurment == -7{
                        
                        if (modelNo >= 9){
                            cuff = "cuff9_8"
                        }else if (modelNo < 9){
                            cuff = "cuff8_8"
                        }
                        
                    }else if cuffMeasurment == -8{
                        
                        if (modelNo >= 9){
                            cuff = "cuff9_9"
                        }else if (modelNo < 9){
                            cuff = "cuff8_9"
                        }
                        
                    }
                    
                    
                    
                    

                 
     //biceps
                    
                    if bicepsMeasurment == 0{
                        biceps = "hook"
                    }else if bicepsMeasurment == -0.5{
                        biceps = "red"
                    }else if bicepsMeasurment == -1.0{
                        biceps = "yellow"
                    }else if bicepsMeasurment == -1.5{
                        biceps = "green"
                    }
                    
            
                    
  //waist
                    if waistMeasurment == 0{
                        waist = "hook"
                    }else if waistMeasurment == -1.0{
                        waist = "red"
                    }else if waistMeasurment == -2.0{
                        waist = "yellow"
                    }else if waistMeasurment == -3.0{
                        waist = "green"
                    }else if waistMeasurment == -4.0{
                        waist = "blue"
                    }

            
   //chest
                    if hipsMeasurment == 0{
                        hips = "hook"
                    }else if hipsMeasurment == -1.0{
                        hips = "red"
                    }else if hipsMeasurment == -2.0{
                        hips = "yellow"
                    }else if hipsMeasurment == -3.0{
                        hips = "green"
                    }else if hipsMeasurment == -4.0{
                        hips = "blue"
                    }
                    
                 
    //chest
                    if chestMeasurment == 0{
                        chest = "hook"
                    }else if chestMeasurment == -1.0{
                        chest = "red"
                    }else if chestMeasurment == -2.0{
                        chest = "yellow"
                    }else if chestMeasurment == -3.0{
                        chest = "green"
                    }else if chestMeasurment == -4.0{
                        chest = "blue"
                    }
               
                    

 //sleeve
                    if sleeveMeasurment == 0{
                        sleeve = "Length_isgood"
                    }else if sleeveMeasurment == -1.0{
                        sleeve = "red-line"
                    }else if sleeveMeasurment == -2.0{
                        sleeve = "yellow-line"
                    }else if sleeveMeasurment == -3.0{
                        sleeve = "green-line"
                    }else if sleeveMeasurment == -4.0{
                        sleeve = "blue-line"
                    }else if sleeveMeasurment == 1.0{
                        sleeve = "oneinch"
                    }else if sleeveMeasurment == 2.0{
                        sleeve = "twoinch"

                    }
                    
                    
  //shoulder
                    if shoulderMeasurment == 0{
                        shoulder = "hook"
                    }else if shoulderMeasurment == -1.0 {
                        shoulder = "red"

                    }else if shoulderMeasurment == -2.0{
                        shoulder = "yellow"

                    }
                    
                    if neckMeasurment == 0{
                        
                        if (modelNo >= 9){
                             neck = "collar1"
                        }else if(modelNo < 9){
                            neck = "neck1"
                        }
                       
 //neck
                    }else if neckMeasurment == -1.0{
                       
                        
                        if (modelNo >= 9){
                           neck = "collar2"
                        }else if(modelNo < 9){
                            neck = "neck2"
                        }
                        
                    }else if neckMeasurment == -2.0{
                        if (modelNo >= 9){
                            neck = "collar3"
                        }else if(modelNo < 9){
                            neck = "neck3"
                        }
                        
                    }else if neckMeasurment == -3.0{
                        
                        if (modelNo >= 9){
                            neck = "collar4"
                        }else if(modelNo < 9){
                            neck = "neck4"
                        }
                        
                    }else if neckMeasurment == -4.0{
                       
                        if (modelNo >= 9){
                            neck = "collar5"
                        }else if(modelNo < 9){
                            neck = "neck5"
                        }
                    }else if neckMeasurment == -5.0{
                        
                        
                        if (modelNo >= 9){
                            neck = "collar6"
                        }else if(modelNo < 9){
                            neck = "neck6"
                        }
                    }else if neckMeasurment == -6.0{
                        
                        
                        if (modelNo >= 9){
                            neck = "collar7"
                        }else if(modelNo < 9){
                            neck = "neck7"
                        }
                    }else if neckMeasurment == -7.0{
                        
                        if (modelNo >= 9){
                            neck = "collar8"
                        }else if(modelNo < 9){
                            neck = "neck8"
                        }
                    }else if neckMeasurment == -8.0{
                        
                        if (modelNo >= 9){
                            neck = "collar9"
                        }else if(modelNo < 9){
                            neck = "neck9"
                        }
                    }else if neckMeasurment == -9.0{
                        
                        if (modelNo >= 9){
                            neck = "collar610"
                        }else if(modelNo < 9){
                            neck = "neck10"
                        }
                    }else if neckMeasurment == -10{
                           neck = "collar11"
                    }
                 
                    if (shoulder == nil) || (sleeve == nil) || (chest == nil) || (waist == nil) || (hips == nil) || (biceps == nil) || (neck == nil) || (cuff == nil) || (length == nil){
                       
                        print("NILL VALUES FOUND")
                    }else{
                         self.objectsArray.append(Objects(sectionNames: "BESPOKE MEASURMENT", sectionObjects: [shoulder!,sleeve!,chest!,waist!,hips!,biceps!,neck!,cuff!,length!], itemName: ["SHOULDER","SLEEVE","CHEST","WAIST","HIPS","BICEPS","NECK","CUFF","LENGTH"]))
                    }
                   
                    self.fetchGetBodyPosture(userid: userid!)
                    DispatchQueue.main.async {
                        
                      
                        self.bespokeTB.reloadData()
                        
                    }
                
                    
                    
                } catch {
                    print(error)
                }
                
            }
            }.resume()
        
        
        
    }

}
