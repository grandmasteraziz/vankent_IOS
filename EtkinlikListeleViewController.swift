//
//  EtkinlikListeleViewController.swift
//  vankentrehberi
//
//  Created by Aziz on 28/07/2017.
//  Copyright © 2017 koddata. All rights reserved.
//

import UIKit
import EFInternetIndicator

class EtkinlikListeleViewController: UIViewController , InternetStatusIndicable{
    
    //EFInternetIndicator Lib
    var internetConnectionIndicator:InternetViewIndicator?

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //check internet connection
        self.startMonitoringInternet(backgroundColor:UIColor.black, style: .CardView , textColor:UIColor.white, message:"Oops...\nInternet Bağlantınızı Kontrol edin!", remoteHostName: "vankent.net")

        
        
        
        
        
       sideMenus()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func sideMenus()
    {
        if revealViewController() != nil {
            
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            revealViewController().rightViewRevealWidth = 160
            
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
            
        }
    }//


}
