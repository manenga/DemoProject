//
//  Mall.swift
//  Mall
//
//  Created by Manenga Mungandi on 2019/03/12.
//  Copyright © 2019 Manenga Mungandi. All rights reserved.
//

import Foundation

public struct Mall {

	var id: Int
	public var name: String
	public var shops: [Shop]


	init(fromDictionary dictionary: NSDictionary) {
        id = dictionary["id"] as! Int
		name = dictionary["name"] as! String
		shops = [Shop]()
        
		if let shopArray = dictionary["shops"] as? [NSDictionary] {
			for dic in shopArray {
				let shop = Shop(fromDictionary: dic)
				shops.append(shop)
			}
		}
	}
}
