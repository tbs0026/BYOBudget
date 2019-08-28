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
    
    var navBar: UINavigationBar = {
        let navig = UINavigationBar()
        navig.backgroundColor = .mint
        $0.increaseSize(100)
        //navig.heightAnchor = 100(NSLayoutDimension)
        //navig.titleTextAttributes = [NSExtensionItemAttributedTitleKey: "Analytics"]
        $0.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        $0.barTintColor = .mint
        $0.isHidden = false
        return $0
    }(UINavigationBar())
    
    override func viewDidLoad() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.addSubview(navBar)
        
        setupConstraints()
    }
    
    func setupConstraints() {
//        navBar.snp.makeConstraints { (make) in
//            make.top.left.right.equalToSuperview()
//            make.height.equalTo(84)
//        }
    }
}
