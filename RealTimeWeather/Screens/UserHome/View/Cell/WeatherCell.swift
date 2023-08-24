//
//  WeatherCell.swift
//  RealTimeWeather
//
//  Created by Pavan Thakkar on 24/08/23.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.dropShadow()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var titleForLabel: String?
    
//    var weather: WeatherInformation? {
//        didSet {
//            configureData()
//        }
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(title: String, message: String) {
        titleLabel.text = title
        messageLabel.text = message
    }
}
