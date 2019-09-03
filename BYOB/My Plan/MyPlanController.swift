//
//  MyPlanController.swift
//  BYOB
//
//  Created by Trevor Smith on 8/28/19.
//  Copyright © 2019 Trevor Smith. All rights reserved.
//

import CoreLocation
import UIKit
import SnapKit

//class MyPlanController: UIViewController {
//    var tableView = MyPlanTableView(frame: UIScreen.main.bounds, style: .plain)
//    override func viewDidLoad() {
//        self.title = "My Plan"
//        self.view.backgroundColor = UIColor(hex: "#eeeeeeff")
//
//        tableView.register(MyPlanCell.self, forCellReuseIdentifier: MyPlanCell.reuse)
//
//        view.addSubview(tableView)
//    }
//}

class MyPlanTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myPlanArray = UserDefaults.standard.array(forKey: "MyPlan")
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyPlanCell.reuse, for: indexPath) as! MyPlanCell
        cell.setupCell(titleIn: "Title", amountIn: 10.0)
        
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
