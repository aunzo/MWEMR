import UIKit
import Material

class CustomerTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var upDownButton: RaisedButton!
    @IBOutlet weak var contentCutomerView: UIView!
    @IBOutlet weak var closeCaseButton: RaisedButton!
    @IBOutlet weak var deleteCaseButton: RaisedButton!
    @IBOutlet weak var editIDButton: RaisedButton!
    
    @IBOutlet weak var closedCaseLabel: UILabel!
    @IBOutlet weak var passportLabel: UILabel!
    
    func configure(item : (fullName:String,gender:String,age:Int,passport:String)) {
        self.nameLabel.text = item.fullName
        self.genderLabel.text = item.gender
        self.ageLabel.text = "\(item.age)"
        self.passportLabel.text = item.passport
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
