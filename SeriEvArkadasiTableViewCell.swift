//
//  SeriEvArkadasiTableViewCell.swift
//  vankentrehberi
//
//  Created by Aziz on 03/08/2017.
//  Copyright © 2017 koddata. All rights reserved.
//

import UIKit

class SeriEvArkadasiTableViewCell: UITableViewCell {
    
    @IBOutlet weak var adi: UILabel!

    @IBOutlet weak var telefonLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 
    }

}
