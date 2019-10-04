//
//  Checkbox.swift
//  BYOB
//
//  Created by Trevor Smith on 10/4/19.
//  Copyright © 2019 Trevor Smith. All rights reserved.
//

import UIKit

class Checkbox: UIButton {
    let checkedImage = UIImage(named: "btchecked")
    let uncheckedImage = UIImage(named: "btunchecked")
    
    var isChecked = false {
        didSet {
            if isChecked {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        
    }
    
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func buttonClicked() {
        isChecked = !isChecked
    }
}
