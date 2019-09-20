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

class MyPlanController: UIViewController {
    var tableView = MyPlanTableView(style: .plain)
    override func viewDidLoad() {
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))

        navigationItem.rightBarButtonItem = add
        self.title = "My Plan"
        self.view.backgroundColor = UIColor(hex: "#eeeeeeff")
        tableView.register(MyPlanCell.self, forCellReuseIdentifier: MyPlanCell.reuse)
//        tableView.delegate = self
//        tableView.dataSource = self

        //tableView.register(MyPlanCell.self, forCellReuseIdentifier: MyPlanCell.reuse)

        view.addSubview(tableView)
        
        setupConstraints()
        }
    
    @objc func addTapped() {
        let myPlanDetail = MyPlanDetail()
        self.navigationController?.pushViewController(myPlanDetail, animated: true)
    }
    func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}



//extension MyPlanController: UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: MyPlanCell.reuse, for: indexPath) as! MyPlanCell
//        cell.setupCell(titleIn: "Title", amountIn: 10.0)
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//
//    }
//}

class MyPlanTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var myPlanArray: [MyPlanObject] = [MyPlanObject(titleIn: "Title", amountIn: 10.0)]
    
    init(style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        self.register(MyPlanCell.self, forCellReuseIdentifier: MyPlanCell.reuse)
        self.dataSource = self
        self.delegate = self
        self.backgroundColor = UIColor(hex: "#eeeeeeff")
        self.separatorStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPlanArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyPlanCell.reuse, for: indexPath) as! MyPlanCell
        cell.setupCell(titleIn: "Title", amountIn: 10.0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    

    
    
    
}
