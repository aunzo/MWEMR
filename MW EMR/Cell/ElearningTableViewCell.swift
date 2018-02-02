import UIKit
import Material

class ElearningTableViewCell: UITableViewCell {

    @IBOutlet weak var titleElearningLabel: UILabel!
    @IBOutlet weak var typeElearningLabel: UILabel!
    @IBOutlet weak var downloadFileButton: RaisedButton!
    @IBOutlet weak var viewPdfButton: RaisedButton!
    @IBOutlet weak var contentCustomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(item : (name:String,path:String,type_name:String)) {
        self.titleElearningLabel.text = item.name
        self.typeElearningLabel.text = item.type_name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
