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

public let expenseCellReuse = "expenseCell"

class ExpensesController: UIViewController, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    var addButton = UIButton()

    var indexKey = "ExpenseIndex"

    var tableView = UITableView()

    var monthlyExpenseKey = StaticFunctions.getMonthlyExpensesKey()

    var objectArray: [ExpenseObject] = []

    override func viewDidLoad() {
        self.title = "Expenses"
        self.view.backgroundColor = UIColor(hex: "#eeeeeeff")
        self.view.addSubview(addButton)
        tableView.register(MyPlanCell.self, forCellReuseIdentifier: MyPlanCell.reuse)
        setupConstraints()
        setupAddButton()
        setupMoreStuff()
    }

    func setupMoreStuff() {
        objectArray = StaticFunctions.decodeExpenseArray()
    }

    func setupAddButton() {
        addButton.backgroundColor = .mint
        addButton.layer.cornerRadius = 40
        addButton.setTitle("+", for: .normal)
        addButton.titleLabel?.font = UIFont(name: "Avenir-Black", size: 80)
        addButton.setTitleColor(.white, for: .normal)
        addButton.addDropShadow(color: .black, offset: CGSize(width: 0, height: 5), radius: 3, opacity: 0.5)
        addButton.addTarget(self, action: #selector(self.addPressedDown), for: .touchDown)
        addButton.addTarget(self, action: #selector(self.addPressedUp), for: .touchDragOutside)
        addButton.addTarget(self, action: #selector(self.addPressedUp), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(self.createNewExpense), for: .touchUpInside)

        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.createNewExpense))
        navigationItem.rightBarButtonItem = add
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        StaticFunctions.decodeGroupArray().count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionArray = StaticFunctions.decodeGroupArray()
        return ""
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyPlanCell.reuse, for: indexPath) as! MyPlanCell
        let expenseObject = objectArray[indexPath.row]
        cell.setupCell(titleIn: expenseObject.title, amountIn: expenseObject.amountSpent)

        return cell

    }

    @objc func addPressedDown() {
        addButton.addDropShadow(opacity: 0)
    }

    @objc func addPressedUp() {
        addButton.addDropShadow(opacity: 0.5)
    }

    @objc func createNewExpense() {
        if StaticFunctions.decodeGroupArray().count == 0 {
            noPlansAlert()
            return
        }
        let expenseObject = ExpenseObject(titleIn: "", amountIn: 0, epochIn: "", categoryIn: "")
        let expensesDetail = ExpensesDetail(expenseObject: expenseObject)
        navigationController?.pushViewController(expensesDetail, animated: true)
    }

    func setupConstraints() {
        addButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
            make.height.width.equalTo(80)
        }
    }

    func noPlansAlert() {
        let alert = UIAlertController(title: "Yo", message: "Please create at least one category in the 'My Plan' feature", preferredStyle: .alert)

        let closeAlert = UIAlertAction(title: "Close", style: .default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(closeAlert)
        self.present(alert, animated: true)
    }
}
