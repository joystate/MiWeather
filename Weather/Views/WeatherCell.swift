//
//  WeatherCell.swift
//  Weather
//
//  Created by Nadia Yudina on 6/15/14.
//  Copyright (c) 2014 Nadia Yudina. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet var mainLabel : UILabel!
    @IBOutlet var dayView : UIImageView!
    @IBOutlet var nigthView : UIImageView!
    @IBOutlet var dayLabel : UILabel?
    @IBOutlet var nightLabel : UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
