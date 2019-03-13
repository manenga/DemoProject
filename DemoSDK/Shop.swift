//
//  Shop.swift
//  Shop
//
//  Created by Manenga Mungandi on 2019/03/12.
//  Copyright © 2019 Manenga Mungandi. All rights reserved.
//

import Foundation

public struct Shop {

	var id: Int
	public var name: String


	init(fromDictionary dictionary: NSDictionary) {
        id = dictionary["id"] as! Int
        name = dictionary["name"] as! String
	}
}
