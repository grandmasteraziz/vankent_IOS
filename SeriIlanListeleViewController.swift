//
//  SeriIlanListeleViewController.swift
//  vankentrehberi
//
//  Created by Aziz on 28/07/2017.
//  Copyright © 2017 koddata. All rights reserved.
//

import UIKit

class SeriIlanListeleViewController: UIViewController {
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    @IBOutlet weak var isArayanBtn: UIButton!
    
    
    @IBOutlet weak var isVerenBtn: UIButton!
    
    @IBOutlet weak var evArkadasiBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        isVerenBtn.layer.cornerRadius = 10
        isArayanBtn.layer.cornerRadius = 10
        evArkadasiBtn.layer.cornerRadius = 10
        
        
        sideMenus()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
