//
//  AnalyticsController.swift
//  BYOB
//
//  Created by Trevor Smith on 8/28/19.
//  Copyright © 2019 Trevor Smith. All rights reserved.
//

import CoreLocation
import UIKit
import SnapKit

class AnalyticsController: UIViewController {
    
    var navBar = NavigationBar(frame: CGRect(x: 0, y: 44, width: UIScreen.main.bounds.width, height: 44))
    
    var statusBarBackground: UIView = {
        $0.backgroundColor = .mint
        return $0
    } (UIView())
    
    func setupNavBar() {
        navBar.setTitleText(title: "Analytics")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = true
        self.view.backgroundColor = UIColor(hex: "#eeeeeeff")
        self.view.addSubview(navBar)
        self.view.addSubview(statusBarBackground)
        setupNavBar()
        setupConstraints()
    }
    
    func setupConstraints() {
        statusBarBackground.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
    }
}
