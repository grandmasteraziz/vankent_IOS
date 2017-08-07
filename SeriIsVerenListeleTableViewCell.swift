//
//  SeriIsVerenListeleTableViewCell.swift
//  vankentrehberi
//
//  Created by Aziz on 03/08/2017.
//  Copyright © 2017 koddata. All rights reserved.
//

import UIKit

class SeriIsVerenListeleTableViewCell: UITableViewCell {

    @IBOutlet weak var adiLbl: UILabel!
    
    @IBOutlet weak var fiyatLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib() 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 
    }

}
