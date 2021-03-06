//
//  DemoSDKTests.swift
//  DemoSDKTests
//
//  Created by Manenga Mungandi on 2019/03/11.
//  Copyright © 2019 Manenga Mungandi. All rights reserved.
//

import XCTest
@testable import DemoSDK

class DemoSDKTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        DemoSDK.shared.setJSON(from: "sample")
        runFunctionalTests(name: "Sample")
        
        DemoSDK.shared.setJSON(from: "test1")
        runFunctionalTests(name: "Demo 1")
        
        DemoSDK.shared.setJSON(from: "test2")
        runFunctionalTests(name: "Demo 2")

    }

    private func runFunctionalTests(name: String) {
        print("\nRunning functional tests - \(name)")
        print("a. As a developer, I would like to request a list of cities.")
        print("All Cities - \(DemoSDK.shared.getCityNames())\n")
        print("b. As a developer, I would like to request a particular city.")
        print("Get Cape Town - \(DemoSDK.shared.get(object: .city, byName: "Cape Town"))\n")
        print("c. As a developer, I would like to request a list of malls in a city.")
        print("Get Malls in Cape Town - \(DemoSDK.shared.get(object: .mallNames, cityName: "Cape Town"))\n")
        print("d. As a developer, I would like to request a particular mall in a city.")
        print("Get V&A Waterfront - \(DemoSDK.shared.getParticular(mallName: "V&A Waterfront", inCityName: "Cape Town"))\n")
        print("e. As a developer, I would like to request a list of shops in a mall.")
        print("Get shops at V&A Waterfront - \(DemoSDK.shared.getShops(cityName: "Cape Town", mallName: "V&A Waterfront"))\n")
        print("f. As a developer, I would like to request a particular shop in a mall.")
        print("Get Nike at Menlin Main in Joburg - \(DemoSDK.shared.getParticular(shopName: "Nike", inMallName: "Menlin Main", cityName: "Johannesburg"))\n")
        print("g. Bonus: As a developer, I would like to request a list of shops in a city")
        print("Get shops in Durban - \(DemoSDK.shared.get(object: .shopNames, cityName: "Durban"))")
        print("Functional tests complete \n")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
