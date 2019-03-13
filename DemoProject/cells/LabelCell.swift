//
//  CityCell.swift
//  DemoProject
//
//  Created by Manenga Mungandi on 2019/03/11.
//  Copyright © 2019 Manenga Mungandi. All rights reserved.
//

import UIKit

class LabelCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(name: String) {
        self.cityName.text = name
    }
}
