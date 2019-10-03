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
        setupConstraints()
        setupKeyboard()
        setupTitle()
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
    
    func setupAmount() {
        if titleTextField.text == "" {
            titleTextField.attributedPlaceholder = NSAttributedString(string: "Enter Amount")
        }
        titleTextField.delegate = self
        titleTextField.backgroundColor = UIColor(hex: "#FFFFFFFF")
        titleTextField.textColor = .black
        titleTextField.layer.cornerRadius = 8.0
        titleTextField.font = UIFont(name: "Avenir-Bold", size: 16)
        titleTextField.borderStyle = .roundedRect
        titleTextField.inputAccessoryView = keyboardToolbar
        titleTextField.keyboardType = UIKeyboardType.numberPad
    }
    
    func setupKeyboard() {
        keyboardToolbar.sizeToFit()
        keyboardToolbar.barTintColor = UIColor(hex: "#eeeeeeff")
        keyboardToolbar.alpha = 1.0
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.dismissKeyboard))
        doneButton.tintColor = .blue
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        keyboardToolbar.setItems([flexSpace, doneButton], animated: false)
        
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
        
        titleTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(titleTextField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.height.equalTo(50)
        }
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
