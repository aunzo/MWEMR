//
//  ProgressionTableViewCell.swift
//  MW EMR
//
//  Created by AunzNuBee on 4/24/2559 BE.
//  Copyright © 2559 AunzNuBee. All rights reserved.
//

import UIKit

class ProgressionTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cgsLabel: UILabel!
    @IBOutlet weak var pupilLabel: UILabel!
    @IBOutlet weak var btLabel: UILabel!
    @IBOutlet weak var prLabel: UILabel!
    @IBOutlet weak var rrLabel: UILabel!
    @IBOutlet weak var spo2Label: UILabel!
    @IBOutlet weak var etco2Label: UILabel!
    @IBOutlet weak var ekgLabel: UILabel!
    @IBOutlet weak var painScoreLabel: UILabel!
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var tmLabel: UILabel!
    @IBOutlet weak var remarkLabel: UILabel!
    @IBOutlet weak var bpLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
