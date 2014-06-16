//
//  WeatherCell.swift
//  Weather
//
//  Created by Nadia Yudina on 6/15/14.
//  Copyright (c) 2014 Nadia Yudina. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    
    @IBOutlet var mainLabel : UILabel
    @IBOutlet var dayView : UIImageView
    @IBOutlet var nigthView : UIImageView
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier)
        
        
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
