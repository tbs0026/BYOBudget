//
//  ExpensesController.swift
//  BYOB
//
//  Created by Trevor Smith on 8/28/19.
//  Copyright © 2019 Trevor Smith. All rights reserved.
//

import CoreLocation
import UIKit
import SnapKit
import DZNEmptyDataSet
import M13Checkbox

class ExpensesController: UIViewController, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    var addButton = UIButton()
    
    func setupAddButton() {
        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = 40
        addButton.setTitle("+", for: .normal)
        addButton.titleLabel?.font = UIFont(name: "Avenir-Black", size: 80)
        addButton.setTitleColor(.white, for: .normal)
        addButton.addDropShadow(color: .black, offset: CGSize(width: 0, height: 5), radius: 3, opacity: 0.5)
        addButton.addTarget(self, action: #selector(self.addPressedDown), for: .touchDown)
        addButton.addTarget(self, action: #selector(self.addPressedUp), for: .touchUpInside)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return ExpensesCell(style: UITableViewCell.CellStyle.default , reuseIdentifier: "this")
    }
    
    @objc func addPressedDown() {
        addButton.addDropShadow(opacity: 0)
    }
    
    @objc func addPressedUp() {
        addButton.addDropShadow(opacity: 0.5)
    }
    
    func setupConstraints() {
        addButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
            make.height.width.equalTo(80)
        }
        
    }
    override func viewDidLoad() {
        self.title = "Expenses"
        self.view.backgroundColor = UIColor(hex: "#eeeeeeff")
        self.view.addSubview(addButton)
        
        setupConstraints()
        setupAddButton()
    }
}
