//
//  ExpensesDetail.swift
//  BYOB
//
//  Created by Trevor Smith on 1/27/20.
//  Copyright © 2020 Trevor Smith. All rights reserved.
//

import SnapKit
import UIKit

class ExpensesDetail: UIViewController, UITextFieldDelegate {
    let keyboardToolbar = UIToolbar()
    var currentExpenseObject: ExpenseObject
    var titleTextField = UITextField()
    var amountTextField = UITextField()
    var epoch = ""
    var amountSpent: Double = 0
    var groupPicker = UIPickerView()
    var indexKey = "ExpenseIndex"
    let monthlyExpensesKey = StaticFunctions.getMonthlyExpensesKey()
    let pickerTitle: UILabel = {
        $0.text = "Category:"
        $0.textAlignment = .center
        $0.textColor = .black
        $0.font = UIFont(name: "Avenir-Black", size: 20)
        return $0
    }(UILabel())
    var myPlanArray: [MyPlanObject] = []

    init(expenseObject: ExpenseObject) {
        currentExpenseObject = expenseObject
        super.init(nibName: nil, bundle: nil)
        amountTextField.text = String(currentExpenseObject.amountSpent)
        titleTextField.text = String(currentExpenseObject.title)
        epoch = currentExpenseObject.epoch
        amountSpent = currentExpenseObject.amountSpent
        myPlanArray = StaticFunctions.decodeGroupArray()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(hex: "#eeeeeeff")
        setupKeyboard()
        setupTextFields()
        groupPicker.delegate = self
        groupPicker.dataSource = self
        view.addSubview(titleTextField)
        view.addSubview(amountTextField)
        view.addSubview(groupPicker)
        view.addSubview(pickerTitle)
        setupConstraints()

    }

    func setupTextFields() {
        if titleTextField.text == "" {
            titleTextField.attributedPlaceholder = NSAttributedString(string: "Log An Expense")
        }
        titleTextField.delegate = self
        titleTextField.backgroundColor = UIColor(hex: "#FFFFFFFF")
        titleTextField.textColor = .black
        titleTextField.layer.cornerRadius = 8.0
        titleTextField.font = UIFont(name: "Avenir-Bold", size: 16)
        titleTextField.borderStyle = .roundedRect
        titleTextField.inputAccessoryView = keyboardToolbar

        if amountTextField.text == "0.0"{
            amountTextField.text = ""
            amountTextField.attributedPlaceholder = NSAttributedString(string: "Enter Amount")
        }
        amountTextField.delegate = self
        amountTextField.backgroundColor = UIColor(hex: "#FFFFFFFF")
        amountTextField.textColor = .black
        amountTextField.layer.cornerRadius = 8.0
        amountTextField.font = UIFont(name: "Avenir-Bold", size: 16)
        amountTextField.borderStyle = .roundedRect
        amountTextField.inputAccessoryView = keyboardToolbar
        amountTextField.keyboardType = .decimalPad
    }

    func setupKeyboard() {
        keyboardToolbar.sizeToFit()
        keyboardToolbar.barTintColor = UIColor(hex: "#eeeeeeff")
        keyboardToolbar.alpha = 1.0
        keyboardToolbar.tintColor = UIColor(hex: "#eeeeeeff")
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.dismissKeyboard))
        doneButton.tintColor = .blue
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        keyboardToolbar.setItems([flexSpace, doneButton], animated: false)
        keyboardToolbar.layer.borderColor = UIColor(hex: "#eeeeeeff")?.cgColor
        keyboardToolbar.clipsToBounds = true
    }

    func setupConstraints() {
        titleTextField.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }

        amountTextField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(titleTextField.snp.bottom).offset(16)
            make.height.equalTo(44)
        }

        pickerTitle.snp.makeConstraints { (make) in
            make.centerY.equalTo(groupPicker)
            make.left.equalToSuperview().offset(4)
        }

        groupPicker.snp.makeConstraints { (make) in
            make.top.equalTo(amountTextField.snp.bottom).offset(16)
            make.right.equalToSuperview()
            make.left.equalTo(pickerTitle.snp.right)
            make.height.equalTo(100)
        }
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

    func cancelAlert() {
        let alert = UIAlertController(title: "You have unsaved changes", message: "Would you like to save this plan?", preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { (_) in
            self.savePressed()
        })
        let editAction = UIAlertAction(title: "Continue Editing", style: .default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "No", style: .default, handler: { (_) in
            self.navigationController?.popViewController(animated: true)
        })

        alert.addAction(cancelAction)
        alert.addAction(editAction)
        alert.addAction(saveAction)
        self.present(alert, animated: true)
    }

    @objc func cancelPressed() {

        self.view.endEditing(true)
        if currentExpenseObject.title != titleTextField.text || currentExpenseObject.amountSpent != Double(amountTextField.text!) {
            cancelAlert()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }

    @objc func savePressed() {
        currentExpenseObject.amountSpent = Double(amountTextField.text!) ?? 0.0
        currentExpenseObject.title = titleTextField.text ?? "New Budget Item"
        currentExpenseObject.dateEdited = Date()
        if currentExpenseObject.title == "" || currentExpenseObject.amountSpent <= 0.005 {
            sendEmptyFieldPopup()
            return
        }
        appendToCachedArray(expenseObject: currentExpenseObject)
        self.navigationController?.popViewController(animated: true)
    }

    func sendEmptyFieldPopup() {
        let alert = UIAlertController(title: "Your Title or Amount field appear to be empty", message: "Please enter a value for these fields", preferredStyle: .alert)

        let editAction = UIAlertAction(title: "Okay", style: .default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(editAction)
        self.present(alert, animated: true)
    }

    func appendToCachedArray(expenseObject: ExpenseObject) {
        var checkNew = true
        var array: [ExpenseObject] = []
        if let jsonStringIn = UserDefaults.standard.string(forKey: monthlyExpensesKey) {
            if let jsonDataIn = jsonStringIn.data(using: .utf8) {
                let myPlanArray = try? JSONDecoder().decode([ExpenseObject].self, from: jsonDataIn)
                array = myPlanArray ?? []

                // checks if the array contains the item, if it does, checkNew = false
                if jsonStringIn.contains(expenseObject.epoch) {
                    checkNew = false
                }
            }
        }

        // appends the item to the array if it is new, and if it is not
        if checkNew {
            array.append(expenseObject)
        } else {
            var index = UserDefaults.standard.integer(forKey: indexKey)
                     // Because the array is sorted in reverse by date
            index = (array.count - 1) - index
            array.remove(at: index)
            array.append(expenseObject)
        }

        // caches the OCVNoteObject
        if let jsonDataOut = try? JSONEncoder().encode(array.self) {
            if let jsonString = String(data: jsonDataOut, encoding: .utf8) {
                UserDefaults.standard.set(jsonString, forKey: monthlyExpensesKey)
            }
        }
    }
}

extension ExpensesDetail: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        myPlanArray[row].title
    }
}

extension ExpensesDetail: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPlanArray.count
    }

}
