//
//  AnasayfaViewController.swift
//  vankentrehberi
//
//  Created by Aziz on 27/07/2017.
//  Copyright © 2017 koddata. All rights reserved.
//

import UIKit

class AnasayfaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        DispatchQueue.main.async {
            // Anasayfaya yönlendir
            let storyboard : UIStoryboard = UIStoryboard(name : "Main" , bundle : nil )
            let anasayfaVC = storyboard.instantiateViewController(withIdentifier: "swReveal") as! SWRevealViewController
            
            self.present(anasayfaVC, animated: true, completion: nil)
        }
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
