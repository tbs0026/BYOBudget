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
    
    var tableView = UITableView()
    var myPlanArray: [MyPlanObject] = [MyPlanObject(titleIn: "Title", amountIn: 10.0)]
    
    override func viewDidLoad() {
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))

        navigationItem.rightBarButtonItem = add
        self.title = "My Plan"
        self.view.backgroundColor = UIColor(hex: "#eeeeeeff")
        setupTableView()

        view.addSubview(tableView)
        
        setupConstraints()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPlanArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyPlanCell.reuse, for: indexPath) as! MyPlanCell
        cell.setupCell(titleIn: "Title", amountIn: 10.0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editCell(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @objc func addTapped() {
        let myPlanDetail = MyPlanDetail()
        self.navigationController?.pushViewController(myPlanDetail, animated: true)
    }
    
    func editCell(indexPath: IndexPath) {
        
        let detail = MyPlanDetail(itemIn: myPlanArray[indexPath.row])
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}



