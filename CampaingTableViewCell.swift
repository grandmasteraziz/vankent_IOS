//
//  CampaingTableViewCell.swift
//  vankentrehberi
//
//  Created by Aziz on 29/07/2017.
//  Copyright © 2017 koddata. All rights reserved.
//""""""""""""""""

import UIKit

class CampaingTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var cellBgImage: UIImageView!
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var adilLbl: UILabel!
    
    @IBOutlet weak var adresLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
