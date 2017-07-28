//
//  ViewController.swift
//  vankentrehberi
//
//  Created by Aziz on 19/06/2017.
//  Copyright © 2017 koddata. All rights reserved.
//

import UIKit
import EFInternetIndicator


class ViewController: UIViewController, InternetStatusIndicable  {
    
    

    //EFInternetIndicator Lib
    var internetConnectionIndicator:InternetViewIndicator?
   
    // Kaydol Butonu
    
    @IBOutlet weak var kaydolBtn: UIButton!
    
    //Giris yap Butonu
   
    @IBOutlet weak var girisYapBtn: UIButton!
    
    @IBOutlet weak var logoIV: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        //check internet connection
        self.startMonitoringInternet(backgroundColor:UIColor.black, style: .CardView , textColor:UIColor.white, message:"Oops...\nInternet Bağlantınızı Kontrol edin!", remoteHostName: "vankent.net")
      
        kaydolBtn.layer.cornerRadius = 10
        girisYapBtn.layer.cornerRadius = 10
         
        
        
        
        
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
     
  
    
    
  
}

