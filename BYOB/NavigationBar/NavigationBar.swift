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

class NavigationBar: UIView {
    
    
    var navTitle: UILabel = {
        $0.text = "title"
        $0.textColor = .black
        $0.font = UIFont(name: "Avenir-Medium", size: 20)
        return $0
    } (UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .mint
        self.tintColor = .mint
        self.addSubview(navTitle)
        setupViews()
    }
    
    func setupViews() {
        navTitle.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
        }
    }
    
    func setTitleText(title: String) {
        navTitle.text = title
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
