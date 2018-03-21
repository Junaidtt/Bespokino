//
//  AboutUsViewController.swift
//  Bespokino
//
//  Created by Bespokino on 15/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var youtubePlayerView: YouTubePlayerView!
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    let videoURL = URL(string:"https://www.youtube.com/watch?v=fXSkM28erD0&feature=youtu.be")
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.title = "BESPOKINO"
        
        if  (videoURL != nil){
            
            youtubePlayerView.loadVideoURL(videoURL!)
        }else{
            let alertController = UIAlertController(title: "Eror", message: "Failed to load video content", preferredStyle: UIAlertControllerStyle.alert)
            
            
            let okAction  = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
 
        
        youtubePlayerView.layer.cornerRadius = 3.0
        youtubePlayerView.layer.masksToBounds = true
        
        if self.revealViewController() != nil {
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        btnMenuButton.target = revealViewController()
        btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        
    }

    @IBAction func cartButtonDidTap(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
        
        
    }
}
