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
import DZNEmptyDataSet

class MyPlanController: UIViewController, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    var indexKey = "MyPlanIndex"
    var tableView = UITableView()
    var myPlanArray: [MyPlanObject] = []
    lazy var monthlyKey = staticFunctions.getMonthlyKey()
    
    
    
    
    override func viewDidLoad() {
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        

        navigationItem.rightBarButtonItem = add
        self.title = "My Plan"
        self.view.backgroundColor = UIColor(hex: "#eeeeeeff")
        setupTableView()
        loadSavedPlans()

        view.addSubview(tableView)
        
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadInputViews()
        tableView.reloadData()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.backgroundColor = UIColor(hex: "#EEEEEEFF")
        tableView.separatorStyle = .none
        tableView.register(MyPlanCell.self, forCellReuseIdentifier: MyPlanCell.reuse)
    }
    
    func loadSavedPlans() {
        let arrayIn = decodeArray()
        myPlanArray = arrayIn.sorted(by: {$0.dateEdited.compare($1.dateEdited) == .orderedDescending})
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPlanArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyPlanCell.reuse, for: indexPath) as! MyPlanCell
        let myPlanObject = myPlanArray[indexPath.row]
        cell.setupCell(titleIn: myPlanObject.title, amountIn: myPlanObject.maxAmount)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editCell(indexPath: indexPath)
        UserDefaults.standard.set(indexPath.row, forKey: indexKey)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.deleteCell(indexPath: indexPath)
        }
    }
    
    //good
    func deleteCell (indexPath: IndexPath) {
        myPlanArray.remove(at: indexPath.row)
        if let jsonDataOut = try? JSONEncoder().encode(myPlanArray.self) {
            if let jsonString = String(data: jsonDataOut, encoding: .utf8) {
                UserDefaults.standard.set(jsonString, forKey: monthlyKey)
            }
        }
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        loadSavedPlans()
        tableView.reloadData()
    }
    
    @objc func addTapped() {
        let myNewPlanObject = MyPlanObject(titleIn: "", maxAmountIn: 0, monthly: false, amountSpentIn: 0, epochIn: getCurrentEpoch())
        let myPlanDetail = MyPlanDetail(itemIn: myNewPlanObject)
        self.navigationController?.pushViewController(myPlanDetail, animated: true)
    }
    
    func editCell(indexPath: IndexPath) {
        
        let detail = MyPlanDetail(itemIn: myPlanArray[indexPath.row])
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    func getCurrentEpoch() -> String {
        return Date().timeIntervalSince1970.toString()
    }
    
    func decodeArray() -> [MyPlanObject] {
        var array: [MyPlanObject] = []
        if let JSONStringIn = UserDefaults.standard.string(forKey: monthlyKey) {
            if let JSONData = JSONStringIn.data(using: .utf8) {
                let cachedArray = try? JSONDecoder().decode([MyPlanObject].self, from: JSONData)
                array = cachedArray ?? []
            }
        }
        return array
    }
    
    
    func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
}



