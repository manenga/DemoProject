//
//  DetailViewCell.swift
//  DemoProject
//
//  Created by Manenga Mungandi on 2019/03/11.
//  Copyright © 2019 Manenga Mungandi. All rights reserved.
//

import UIKit

class DetailViewCell: UICollectionViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    enum IconType { case shop; case mall }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(titleText: String, type: IconType) {
        self.name.text = titleText
        
        
        switch type {
        case .mall:
            self.icon.image = #imageLiteral(resourceName: "mall")
        default:
            self.icon.image = #imageLiteral(resourceName: "shop")
        }
    }
}
