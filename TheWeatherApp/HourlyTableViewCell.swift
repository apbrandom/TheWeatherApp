//
//  HourlyTableViewCell.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 14.10.2023.
//

import UIKit

class HourlyTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "HourlyTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with hour: HourModel?) {
            // Здесь вы можете настроить вашу ячейку на основе данных модели "HourModel"
            // ...
        }

}

