//
//  MainController.swift
//  DemoProject
//
//  Created by Manenga Mungandi on 2019/03/11.
//  Copyright © 2019 Manenga Mungandi. All rights reserved.
//
//  Showcasing:
//      - a clear list of all cities
//      - requesting a particular city
//

import UIKit
import DemoSDK

class MainController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var isLoading = true
    private var printLogs = false
    private var useSample = true // false
    
    private let alert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        //  if JSON is already loaded don't reload list
        if !DemoSDK.shared.hasJSON() {
            self.prepareList()
            self.showLoading()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.title = "Showcase"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func prepareList() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 45
        tableView.register(UINib.init(nibName: "LabelCell", bundle: nil), forCellReuseIdentifier: "LabelCell")
        
        if useSample {
            DemoSDK.shared.setJSON(from: "sample")
        } else {
            DemoSDK.shared.setJSON(fromURL: "http://www.mocky.io/v2/5b7e8bc03000005c0084c210")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.tableView.reloadData()
            self.alert.dismiss(animated: false, completion: nil)
            
            if self.printLogs {
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
            }
        }
    }
    
    private func showLoading() {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
}

extension MainController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DemoSDK.shared.getCities().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell") as! LabelCell
        let name = DemoSDK.shared.getCities().compactMap({ $0.name })[indexPath.row]
        cell.setCell(name: name)
        
        if ((DemoSDK.shared.get(object: .malls, cityName: name).count) < 1) {
            cell.accessoryType = .detailButton
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = DemoSDK.shared.getCities().compactMap({ $0.name })[indexPath.row]
        let controller = CityController.create(cityName: name)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

