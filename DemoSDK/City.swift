//
//  City.swift
//  City
//
//  Created by Manenga Mungandi on 2019/03/12.
//  Copyright © 2019 Manenga Mungandi. All rights reserved.
//

import Foundation

public struct City {

	var id: Int
	public var malls: [Mall]
	public var name: String

	init(fromDictionary dictionary: NSDictionary) {
		id = dictionary["id"] as! Int
		malls = [Mall]()
        
		if let mallArray = dictionary["malls"] as? [NSDictionary] {
			for dic in mallArray {
				let mall = Mall(fromDictionary: dic)
				malls.append(mall)
			}
		}
        
		name = dictionary["name"] as? String ?? "No name"
	}

}
