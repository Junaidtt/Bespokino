//
//  TuxedoViewController.swift
//  Bespokino
//
//  Created by Bespokino on 11/21/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class TuxedoViewController: UIViewController,UIGestureRecognizerDelegate {

    @IBOutlet weak var yesTuxedoView: UIView!
    @IBOutlet weak var withPleatsView: UIView!
   

    override func viewDidLoad() {
    
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.yesTuxedoViewTap(_:)))
        
        yesTuxedoView.addGestureRecognizer(tap)
        
        yesTuxedoView.isUserInteractionEnabled = true
        
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.withPleatsViewTap(_:)))
        
        withPleatsView.addGestureRecognizer(tap2)
        
        withPleatsView.isUserInteractionEnabled = true
        
        
        yesTuxedoView.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)

        yesTuxedoView.layer.borderWidth = 2

    }

    @objc func yesTuxedoViewTap(_ sender: UITapGestureRecognizer) {

        yesTuxedoView.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        withPleatsView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        yesTuxedoView.layer.borderWidth = 2
        
        yesTuxedoView.layer.shadowRadius = 3
        yesTuxedoView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        StylingTask.tuxedo  = "527"
        StylingTask.tuxedoPleat = ""
        
        AdditionalOptions.tuxedo  = "527"
        AdditionalOptions.tuxedoPleat = ""
        
  

    }
    
    
    @objc func withPleatsViewTap(_ sender: UITapGestureRecognizer) {
        
        withPleatsView.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)
        yesTuxedoView.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0, alpha: 1)

        
        withPleatsView.layer.borderWidth = 2
        
        withPleatsView.layer.shadowRadius = 3
        withPleatsView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        StylingTask.tuxedo = "527"
        StylingTask.tuxedoPleat = "544"
        
        AdditionalOptions.tuxedo = "527"
        AdditionalOptions.tuxedoPleat = "544"
        
 


        
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
}
