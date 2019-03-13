//
//  DemoSDK.swift
//  DemoSDK
//
//  Created by Manenga Mungandi on 2019/03/11.
//  Copyright © 2019 Manenga Mungandi. All rights reserved.
//
//  Showcasing:
//      -   a. As a developer, I would like to request a list of cities.
//      -   b. As a developer, I would like to request a particular city.
//      -   c. As a developer, I would like to request a list of malls in a city.
//      -   d. As a developer, I would like to request a particular mall in a city.
//      -   e. As a developer, I would like to request a list of shops in a mall.
//      -   f. As a developer, I would like to request a particular shop in a mall.
//      -   g. Bonus: As a developer, I would like to request a list of shops in a city
//

import UIKit

public class DemoSDK: NSObject {
    
    public static let shared = DemoSDK()
    private var json: NSDictionary?
    
    public enum ObjectType { case none; case city; case mall; case shop; case malls; case shops; case mallNames; case shopNames; }
    
    public func setJSON(fromURL: String) {
        json = loadJSON(fromURL)
    }
    
    public func setJSON(from filename: String) {
        json = loadJSON(named: filename)
    }
    
    public func hasJSON() -> Bool {
        return json != nil
    }
    
    //    a) request a list of cities
    public func getCities() -> [City] {
        return Root.init(fromDictionary: json).cities
    }
    
    public func getCityNames() -> [String] {
        return getCities().compactMap({ $0.name })
    }
    
    //    b) request a particular city
    internal func getCityBy(name: String) -> City? {
        var cities = getCities().filter({ $0.name == name })
        return cities.popLast()
    }
    
    public func get(object: ObjectType, byName: String) -> Any? {
        switch object {
        case .city:
            return getCityBy(name: byName)
        default:
            return nil
        }
    }
    
    public func get(object: ObjectType, cityName: String) -> [Any] {
        switch object {
        case .malls:
            return getMalls(byCity: cityName)
        case .shops:
            return getShops(byCity: cityName)
        case .mallNames:
            return getMalls(byCity: cityName).compactMap({ $0.name })
        case .shopNames:
            return getShops(byCity: cityName).compactMap({ $0.name })
        default:
            return []
        }
    }
    
    //  c) request a list of malls in a city
    internal func getMalls(byCity: String) -> [Mall] {
        let cities = getCities()
        for city in cities {
            if byCity == city.name {
                return city.malls
            }
        }
        return []
    }
    
    //  d) request a particular mall in a city.
    public func getParticular(shopName: String, inMallName: String, cityName: String) -> Shop? {
        let shops = getShops(cityName: cityName, mallName: inMallName).filter({ $0.name == shopName })
        return shops.first
    }
    
    //  e) request a list of shops in a mall
    public func getShops(cityName: String, mallName: String) -> [Shop] {
        return getMalls(byCity: cityName).filter({ $0.name == mallName }).first?.shops ?? []
    }
    
    //  f) request a particular shop in a mall.
    public func getParticular(mallName: String, inCityName: String) -> Mall? {
        if let malls = get(object: .malls, cityName: inCityName) as? [Mall] {
            return malls.filter({ $0.name == mallName }).first
        }
        return nil
    }
    
    //  g) request a list of shops in a city
    internal func getShops(byCity: String) -> [Shop] {
        var shops: [Shop] = []
        let malls = getMalls(byCity: byCity)
        
        for mall in malls {
            shops.append(contentsOf: mall.shops)
        }
        return shops
    }
    
    //  Load JSON files by url
    internal func loadJSON(_ address: String) -> NSDictionary? {
        if let url = NSURL(string: address) as URL? {
            if let data = NSData.init(contentsOf: url) {
                do {
                    return try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? NSDictionary
                } catch {
                    print("Sorry. Failed to parse file. Try another method.")
                }
            }
            print("Sorry. Failed to open file. Try another method.")
        }
        return nil
    }
    
    //  Load JSON files by path name
    internal func loadJSON(named filename: String) -> NSDictionary? {
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
            do {
                let data = try NSData.init(contentsOfFile: path, options: .mappedIfSafe)
                return try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? NSDictionary
            } catch {
                print("Sorry. Failed to parse file. Try another method.")
            }
            print("Sorry. Failed to open file. Try another method.")
        }
        return nil
    }
}
