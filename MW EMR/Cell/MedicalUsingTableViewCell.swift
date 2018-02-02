//
//  MedicalUsingTableViewCell.swift
//  MW EMR
//
//  Created by AunzNuBee on 4/23/2559 BE.
//  Copyright © 2559 AunzNuBee. All rights reserved.
//

import UIKit

class MedicalUsingTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
