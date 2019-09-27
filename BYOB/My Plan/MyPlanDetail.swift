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
    
    let textField = UITextField()
    override func viewDidLoad() {
        title = "My Plan"
        self.view.backgroundColor = UIColor(hex: "#eeeeeeff")
        
    }
    
    init(itemIn: MyPlanObject) {
        super.init(nibName: nil, bundle: nil)
        
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func saveObject() {
    var arrayIn = UserDefaults.standard.array(forKey: "MyPlan")
        let myObject = MyPlanObject(titleIn: "Title", amountIn: 4.0)
        arrayIn?.append(myObject)
        UserDefaults.standard.set(arrayIn, forKey: "MyPlan")
    }
}
