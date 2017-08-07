//
//  OtoKiralikTableViewCell.swift
//  vankentrehberi
//
//  Created by Aziz on 03/08/2017.
//  Copyright © 2017 koddata. All rights reserved.
//

import UIKit

class OtoKiralikTableViewCell: UITableViewCell {

    @IBOutlet weak var kapakFoto: UIImageView!
    
 
    @IBOutlet weak var adiLbl: UILabel!
    
    
    @IBOutlet weak var fiyatLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
