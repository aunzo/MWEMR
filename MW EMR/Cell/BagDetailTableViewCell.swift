//
//  BagDetailTableViewCell.swift
//  MW EMR
//
//  Created by AunzNuBee on 6/8/2559 BE.
//  Copyright © 2559 AunzNuBee. All rights reserved.
//

import UIKit

class BagDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var nodataLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureMedication(item : (barcode:String,name:String,amount:Int,typeName:String)) {
        self.codeLabel.text = item.barcode
        self.nameLabel.text = item.name
        self.typeLabel.text = item.typeName
        self.amountLabel.text = "\(item.amount)"
    }
    
    func configureEquipment(item : (barcode:String,name:String,typeName:String)) {
        self.codeLabel.text = item.barcode
        self.nameLabel.text = item.name
        self.typeLabel.text = item.typeName
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
