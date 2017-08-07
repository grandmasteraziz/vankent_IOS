//
//  OtoListeleViewController.swift
//  vankentrehberi
//
//  Created by Aziz on 28/07/2017.
//  Copyright © 2017 koddata. All rights reserved.
//

import UIKit

class OtoListeleViewController: UIViewController  {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    @IBOutlet weak var satilikBtn: UIButton!
    
    
    @IBOutlet weak var kiralikBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        kiralikBtn.layer.cornerRadius = 10
        satilikBtn.layer.cornerRadius = 10
        
        
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
