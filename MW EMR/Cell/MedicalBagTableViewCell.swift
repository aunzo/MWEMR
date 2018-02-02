import UIKit
import Material

class MedicalBagTableViewCell: UITableViewCell {

    @IBOutlet weak var bagNameLabel: UILabel!
    @IBOutlet weak var downloadButton: RaisedButton!
    @IBOutlet weak var contentCutomerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(item : (bag_id:Int,name:String)) {
        self.bagNameLabel.text = item.name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
