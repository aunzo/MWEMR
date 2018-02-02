import UIKit
import MGSwipeTableCell

class SummaryReportTableViewCell: MGSwipeTableCell {

    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var titleReportLabel: UILabel!
    @IBOutlet weak var nodataLabel: UILabel!
    @IBOutlet weak var openFileButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
