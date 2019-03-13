//
//  MallController.swift
//  DemoProject
//
//  Created by Manenga Mungandi on 2019/03/12.
//  Copyright © 2019 Manenga Mungandi. All rights reserved.
//
//  Showcasing:
//      - when I select a mall, I would like to see a list of shops in that mall
//

import UIKit
import DemoSDK

class MallController: UIViewController {
    
    var cityName: String = ""
    var mallName: String = ""
    var demo: DemoSDK?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var keyLabel: UILabel!
    
    class func create(cityName: String, mallName: String, demo: DemoSDK?) -> MallController {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MallController") as! MallController
        vc.mallName = mallName
        vc.cityName = cityName
        vc.demo = demo
        
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = mallName
        self.keyLabel.text = "Shops at \(mallName)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "LabelCell", bundle: nil), forCellReuseIdentifier: "LabelCell")
    }
    
}

extension MallController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demo?.getShops(cityName: cityName, mallName: mallName).count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell") as! LabelCell
        cell.accessoryType = .none
        
        if let shops = demo?.getShops(cityName: cityName, mallName: mallName) {
            let name = shops.compactMap({ $0.name })[indexPath.row]
            cell.setCell(name: name)
        }
        
        return cell
    }
    
}

