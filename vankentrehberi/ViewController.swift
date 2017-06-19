//
//  ViewController.swift
//  vankentrehberi
//
//  Created by Aziz on 19/06/2017.
//  Copyright © 2017 koddata. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FacebookShare
import SDWebImage
import EFInternetIndicator

class ViewController: UIViewController, InternetStatusIndicable {

    //EFInternetIndicator Lib
    var internetConnectionIndicator:InternetViewIndicator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        //check internet connection
        self.startMonitoringInternet(backgroundColor:UIColor.black, style: .CardView , textColor:UIColor.white, message:"Oops... \n Internet Bağlantınızı Kontrol edin!", remoteHostName: "vankent.net")
 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

