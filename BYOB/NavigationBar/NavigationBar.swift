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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .mint
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
