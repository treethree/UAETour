//
//  AttractionTableViewCell.swift
//  UAETour
//
//  Created by SHILEI CUI on 3/30/19.
//  Copyright © 2019 scui5. All rights reserved.
//

import UIKit

class AttractionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var contactLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var distLbl: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var mapBtnLbl: UIButton!
    @IBOutlet weak var webBtnLbl: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mapBtnLbl.layer.cornerRadius = 0.4 * mapBtnLbl.bounds.size.width
        mapBtnLbl.clipsToBounds = true
        
        webBtnLbl.layer.cornerRadius = 0.5 * webBtnLbl.bounds.size.width
        webBtnLbl.clipsToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
