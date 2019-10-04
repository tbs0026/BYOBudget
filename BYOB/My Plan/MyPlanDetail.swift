//
//  MyPlanDetail.swift
//  BYOB
//
//  Created by Trevor Smith on 9/3/19.
//  Copyright © 2019 Trevor Smith. All rights reserved.
//

import UIKit
import SnapKit

class MyPlanDetail: UIViewController, UITextFieldDelegate{
    let keyboardToolbar = UIToolbar()
    let titleTextField = UITextField()
    let amountTextField = UITextField()
    var currentObject = MyPlanObject(titleIn: "", amountIn: 0)
    var monthlyLabel = UILabel()
    let checkedImage = UIImage(named: "btchecked")
    let uncheckedImage = UIImage(named: "btunchecked")
    
    var isChecked = false {
        didSet {
            if isChecked {
                monthlyCheckbox.setImage(checkedImage, for: .normal)
            } else {
                monthlyCheckbox.setImage(uncheckedImage, for: .normal)
            }
        }
    }
    
    let monthlyCheckbox = UIButton()
    var cancelButton = UIBarButtonItem()
    var saveButton = UIBarButtonItem()
    
    
    override func viewDidLoad() {
        title = "My Plan"
        cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelPressed))
        saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(self.savePressed))
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
        self.view.backgroundColor = UIColor(hex: "#eeeeeeff")
        self.view.addSubview(titleTextField)
        self.view.addSubview(amountTextField)
        self.view.addSubview(monthlyCheckbox)
        self.view.addSubview(monthlyLabel)
        setupConstraints()
        setupKeyboard()
        setupTitle()
        setupAmount()
        setupMonthlyCheckbox()
    }
    
    init(itemIn: MyPlanObject) {
        super.init(nibName: nil, bundle: nil)
        currentObject = itemIn
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitle() {
        if titleTextField.text == "" {
            titleTextField.attributedPlaceholder = NSAttributedString(string: "Enter Title")
        }
        titleTextField.delegate = self
        titleTextField.backgroundColor = UIColor(hex: "#FFFFFFFF")
        titleTextField.textColor = .black
        titleTextField.layer.cornerRadius = 8.0
        titleTextField.font = UIFont(name: "Avenir-Bold", size: 16)
        titleTextField.borderStyle = .roundedRect
        titleTextField.inputAccessoryView = keyboardToolbar
    }
    
    func setupMonthlyCheckbox() {
        monthlyLabel.text = "Make this a monthly budgeted item"
        monthlyLabel.textColor = .darkGray
        monthlyLabel.font = UIFont(name: "Avenir-Medium", size: 16)
        if isChecked {
            monthlyCheckbox.setImage(checkedImage, for: .normal)
        } else {
            monthlyCheckbox.setImage(uncheckedImage, for: .normal)
        }
        monthlyCheckbox.addTarget(self, action: #selector(self.checkboxClicked), for: .touchUpInside)
        }
    
    func setupAmount() {
        if amountTextField.text == "" {
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
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func setupConstraints() {
        titleTextField.snp.makeConstraints{ (make) in
            make.top.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.height.equalTo(50)
        }
        
        amountTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(titleTextField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.height.equalTo(50)
        }
        
        monthlyLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(amountTextField.snp.bottom).offset(26)
            make.left.equalTo(monthlyCheckbox.snp.right).offset(4)
        }
        
        monthlyCheckbox.snp.makeConstraints{ (make) in
            make.top.equalTo(amountTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.height.width.equalTo(40)
        }
    }
    
    @objc func checkboxClicked() {
        isChecked = !isChecked
        monthlyCheckbox.reloadInputViews()
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
        if currentObject.title != titleTextField.text || currentObject.amount.toString() != amountTextField.text {
            cancelAlert()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func savePressed() {
        var arrayIn = UserDefaults.standard.array(forKey: "MyPlan")
        let myObject = MyPlanObject(titleIn: "Title", amountIn: 4.0)
        arrayIn?.append(myObject)
        UserDefaults.standard.set(arrayIn, forKey: "MyPlan")
        self.navigationController?.popViewController(animated: true)
    }
}
