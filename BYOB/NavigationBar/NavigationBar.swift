//
//  NavigationBar.swift
//  BYOB
//
//  Created by Trevor Smith on 8/28/19.
//  Copyright © 2019 Trevor Smith. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation

class NavigationBar: UINavigationBar {
    
    let backButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.reply, target: nil, action: #selector(homeScreen))
    
    let navItem = UINavigationItem(title: "NavBar")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .mint
        backButton.tintColor = .black
        navItem.leftBarButtonItem = backButton
        self.setItems([navItem], animated: false)
    }
    
    
    
    func setTitleText(title: String) {
        navItem.title = title
        //self.topItem?.title = title
    }
    
    @objc func homeScreen() {
        //self.back
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
