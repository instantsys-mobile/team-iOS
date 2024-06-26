import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var addresslabel2: UILabel!
    @IBOutlet weak var addresslabel1: UILabel!
    @IBOutlet weak var image2label: UIImageView!
    @IBOutlet weak var image1Label: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupUI(data: DataModel) {
        self.image1Label.image = UIImage(named: data.photo1)
        self.image2label.image = UIImage(named: data.photo2)
        self.addresslabel1.text = data.address1
        self.addresslabel2.text = data.address2
        self.dateLabel.text = data.date
        self.timeLabel.text = data.time
    }
}
