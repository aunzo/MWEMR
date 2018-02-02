//
//  InterventionTableViewCell.swift
//  MW EMR
//
//  Created by AunzNuBee on 5/7/2559 BE.
//  Copyright © 2559 AunzNuBee. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class InterventionTableViewCell: MGSwipeTableCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var interventionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noDataLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
