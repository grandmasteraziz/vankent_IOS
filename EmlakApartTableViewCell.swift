//
//  EmlakApartTableViewCell.swift
//  vankentrehberi
//
//  Created by Aziz on 02/08/2017.
//  Copyright © 2017 koddata. All rights reserved.
//

import UIKit

class EmlakApartTableViewCell: UITableViewCell {

    
    @IBOutlet weak var kapakFoto: UIImageView!
    
    @IBOutlet weak var fiyat: UILabel!
    
    @IBOutlet weak var Adi: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
