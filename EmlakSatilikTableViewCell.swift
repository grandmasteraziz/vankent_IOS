//
//  EmlakSatilikTableViewCell.swift
//  vankentrehberi
//
//  Created by Aziz on 31/07/2017.
//  Copyright © 2017 koddata. All rights reserved.
//

import UIKit

class EmlakSatilikTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var kapakFoto: UIImageView!
    
    @IBOutlet weak var bgImage: UIImageView!
    
    @IBOutlet weak var fiyatiLbl: UILabel!
    @IBOutlet weak var adiLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
