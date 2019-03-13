//
//  Root.swift
//  Root
//
//  Created by Manenga Mungandi on 2019/03/12.
//  Copyright © 2019 Manenga Mungandi. All rights reserved.
//

import Foundation

public struct Root {

	public var cities: [City]

    init(fromDictionary dictionary: NSDictionary?) {
		cities = [City]()
        if let citiesArray = dictionary?["cities"] as? [NSDictionary] {
			for dic in citiesArray{
				let value = City(fromDictionary: dic)
				cities.append(value)
			}
		}
	}
}
