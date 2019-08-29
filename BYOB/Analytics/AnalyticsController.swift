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
    
//    var navBar = NavigationBar(frame: CGRect(x: 0, y: 44, width: UIScreen.main.bounds.width, height: 44))
    
//    var backButton: UIButton = {
//        $0.setImage(#imageLiteral(resourceName: "round_keyboard_arrow_left_black_18dp"), for: UIControl.State.normal)
//        $0.setTitle("Back", for: .normal)
//        $0.setTitleColor(.black, for: .normal)
//        return $0
//    } (UIButton())
    
//    var statusBarBackground: UIView = {
//        $0.backgroundColor = .mint
//        return $0
//    } (UIView())
    
//    func setupNavBar() {
//        navBar.setTitleText(title: "Analytics")
//        backButton.addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "#eeeeeeff")
//        self.view.addSubview(navBar)
//        self.view.addSubview(statusBarBackground)
//        navBar.addSubview(backButton)
        title = "Analytics"
        setupConstraints()
    }
    
    @objc func backButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    func setupConstraints() {
//        statusBarBackground.snp.makeConstraints { (make) in
//            make.top.left.right.equalToSuperview()
//            make.height.equalTo(44)
//        }
        
//        backButton.snp.makeConstraints { (make) in
//            make.left.equalToSuperview().offset(5)
//            make.centerY.equalToSuperview()
//            make.height.equalTo(34)
//        }
    }
}
