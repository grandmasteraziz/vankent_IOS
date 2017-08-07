//
//  HomeViewController.swift
//  vankentrehberi
//
//  Created by Aziz on 28/07/2017.
//  Copyright © 2017 koddata. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenus()
     //   customizeNavbar() //Eğer navbar ın renginin turuncu olmasını istersen yap
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
    
    func customizeNavbar()
    {
        navigationController?.navigationBar.tintColor = UIColor(colorLiteralRed: 255, green: 255, blue: 255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 255, green: 87, blue: 35, alpha: 1)
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }
    

}
