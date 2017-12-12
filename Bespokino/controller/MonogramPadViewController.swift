//
//  MonogramPadViewController.swift
//  Bespokino
//
//  Created by Bespokino on 11/16/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class MonogramPadViewController: UIViewController,UITextFieldDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {


    @IBOutlet weak var monoTextField: UITextField!
    @IBOutlet weak var simpleMonogramButton: UIButton!
    @IBOutlet weak var scriptMonogramButton: UIButton!
    @IBOutlet weak var fancyMonogramButton: UIButton!
    
    var thread:Thread = Thread()
    var monoStyle:String!
    var threadCode:String!
    let stylingtask = StylingTask()
    var positionSelected:String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        self.navigationItem.title = "BESPOKINO"
        
        monoTextField.layer.borderWidth = 0.5
        monoTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        simpleMonogramButton.layer.borderWidth = 0.5
        simpleMonogramButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        scriptMonogramButton.layer.borderWidth = 0.5
        scriptMonogramButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        fancyMonogramButton.layer.borderWidth = 0.5
        fancyMonogramButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func simpleButtonTapped(_ sender: Any) {
        
        simpleMonogramButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        scriptMonogramButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        fancyMonogramButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.monoStyle = "simple"
        
    }
    
    @IBAction func scriptButtonTapped(_ sender: Any) {
        
        simpleMonogramButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        scriptMonogramButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        fancyMonogramButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.monoStyle = "script"

        
    }
    
    @IBAction func fancyButtonTapped(_ sender: Any) {
        
        
        simpleMonogramButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        scriptMonogramButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        fancyMonogramButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        self.monoStyle = "fancy"

        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 8
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       return thread.menuItems.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "color", for: indexPath) as! ThreadCollectionViewCell
        
        let item = thread.menuItems[indexPath.row]
        print(item)
        let img = UIImage(named:item["Image"]!)
        
        cell.threadImage.image = img
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        let item = thread.menuItems[indexPath.row]

        self.threadCode = item["code"]!
        
        cell?.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        cell?.layer.borderWidth = 2

        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell?.layer.borderWidth = 2
    }
    @IBAction func applyButtonTapped(_ sender: Any) {
        
        let async = AsyncTask(view:self)
        var monoText = monoTextField.text
        
        if (monoText?.isEmpty)! {
        async.displayAlertMessage(messageToDisplay: "Empty monogram text field not allowed")
        }
        
        if (self.monoStyle == nil) {
            
            async.displayAlertMessage(messageToDisplay: "Choose your style")

        }
        
        if(self.threadCode == nil){
            
            async.displayAlertMessage(messageToDisplay: "Choose thread color")

            
        }
        
        if ((monoText?.isEmpty)! && (self.monoStyle == nil) && (self.threadCode == nil)) {
            
            async.displayAlertMessage(messageToDisplay: "select all options")
       
        }else{
            
 
            
            stylingtask.monogramInserttask(monoTxt: monoText!, style: self.monoStyle, threadCode: self.threadCode, position: self.positionSelected!, completion: { (success, result, Error) in
                if success {
                    
                    print(result!)
                    
                    
         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AdditionalOptionsViewController") as! AdditionalOptionsViewController
         self.navigationController?.pushViewController(newViewController, animated: true)
                    
                    
                    
                }
            })
         

            
        }
        
        
    }
    
}
