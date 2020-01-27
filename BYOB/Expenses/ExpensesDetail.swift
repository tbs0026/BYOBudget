//
//  ExpensesDetail.swift
//  BYOB
//
//  Created by Trevor Smith on 1/27/20.
//  Copyright © 2020 Trevor Smith. All rights reserved.
//

import SnapKit
import UIKit

class ExpensesDetail: UIViewController {
    var currentExpenseObject: ExpenseObject
    var titleTextField = UITextField()
    var amountTextField = UITextField()
    var epoch = ""
    var amountSpent: Double = 0
    
    let headerView: UIView = {
        $0.backgroundColor = .mint
        return $0
    } (UIView())
    
    let headerLabel: UILabel = {
        $0.text = "New Expense"
        $0.textAlignment = .center
        return $0
    } (UILabel())
    
    init(expenseObject: ExpenseObject) {
        currentExpenseObject = expenseObject
        super.init(nibName: nil, bundle: nil)
        amountTextField.text = String(currentExpenseObject.amountSpent)
        titleTextField.text = String(currentExpenseObject.title)
        epoch = currentExpenseObject.epoch
        amountSpent = currentExpenseObject.amountSpent
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(hex: "#eeeeeeff")
        self.view.addSubview(headerView)
        headerView.addSubview(headerLabel)
    }
    
    func setupConstraints() {
        headerView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(44)
        }
        headerLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
