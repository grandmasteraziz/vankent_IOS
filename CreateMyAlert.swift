//
//  CreateMyAlert.swift
//  vankentrehberi
//
//  Created by Aziz on 04/08/2017.
//  Copyright © 2017 koddata. All rights reserved.
//

import Foundation
class CreateMyAlert{
    
    func createAlert(titleText : String , messageText : String)
    {
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Kapat" , style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }))
         present(alert, animated: true, completion: nil)
    }

}
