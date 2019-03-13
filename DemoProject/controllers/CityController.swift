//
//  CityController.swift
//  DemoProject
//
//  Created by Manenga Mungandi on 2019/03/11.
//  Copyright © 2019 Manenga Mungandi. All rights reserved.
//
//  Showcasing:
//      - when I select a city, I would like to see the malls in that city.
//      - when I select a city, I would like to be able to see a list of all shops in that city.
//      - when I select a mall, I would like to see a list of shops in that mall
//

import UIKit
import DemoSDK

class CityController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    enum TabType {
        case shop
        case mall
    }
    
    var cityName: String = ""
    var demo: DemoSDK?
    
    private var displayType: TabType = .mall
    
    class func create(cityName: String, demo: DemoSDK?) -> CityController {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CityController") as! CityController
        vc.cityName = cityName
        vc.demo = demo
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = cityName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @IBAction func tabChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            displayType = .shop
        default:
            displayType = .mall
        }
        
        collectionView.reloadData()
    }
}

extension CityController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (displayType == .shop) {
            return demo?.get(object: .shops, cityName: cityName).count ?? 0
        } else {
            return demo?.get(object: .malls, cityName: cityName).count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailViewCell", for: indexPath) as! DetailViewCell
        
        if (displayType == .shop) {
            if let shops = demo?.get(object: .shops, cityName: cityName) as? [Shop] {
                let name = shops[indexPath.row].name
                cell.setCell(titleText: name, type: .shop)
            }
            
            return cell
        } else {
            if let malls = demo?.get(object: .malls, cityName: cityName) as? [Mall] {
                let name: String = malls[indexPath.row].name
                cell.setCell(titleText: name, type: .mall)
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (displayType == .mall) {
            if let malls = demo?.get(object: .malls, cityName: cityName) as? [Mall] {
                let mallName: String = malls[indexPath.row].name
                let controller = MallController.create(cityName: cityName, mallName: mallName, demo: demo)
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
}
