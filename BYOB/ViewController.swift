//
//  ViewController.swift
//  BYOB
//
//  Created by Trevor Smith on 8/15/19.
//  Copyright © 2019 Trevor Smith. All rights reserved.
//

import UIKit
import CoreLocation
import SnapKit

class ViewController: UIViewController {
    var graphView: UIView = {
        $0.backgroundColor = UIColor(hex: "#ddddddff")
        $0.layer.cornerRadius = 60.0
        return $0
    } (UIView())
    
    var planView: UIView = {
        $0.backgroundColor = UIColor(hex: "#ddddddff")
        $0.layer.cornerRadius = 60.0
        return $0
    } (UIView())
    
    var graphButton: UIButton = {
        $0.alpha = 1.0
        $0.setImage(#imageLiteral(resourceName: "bars"), for: UIControl.State.normal)
        return $0
    } (UIButton())
    
    var planButton: UIButton = {
        $0.alpha = 1.0
        $0.setImage(#imageLiteral(resourceName: "form"), for: UIControl.State.normal)
        return $0
    } (UIButton())
    
    var dateHeader: UILabel {
        var labelHead = UILabel()
        labelHead.text = getCurrentMonth()
        labelHead.textColor = .black
        labelHead.font = UIFont?.none
    }
    
    func getCurrentMonth() -> String {
        let formatterMonth = DateFormatter()
        formatterMonth.dateFormat = "MMMM"
        let dateMonth = formatterMonth.string(from: Date())
        return dateMonth
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#cfffe5ff")
        view.addSubview(graphView)
        view.addSubview(planView)
        graphView.addSubview(graphButton)
        planView.addSubview(planButton)
        setupConstraints()
    }
    
    func setupConstraints() {
        
        graphView.snp.makeConstraints { (make) in
            make.center.equalToSuperview().inset(-80)
            make.height.width.equalTo(120)
        }
        
        planView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(80)
            make.centerY.equalToSuperview().offset(-80)
            make.height.width.equalTo(120)
        }
        
        graphButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        planButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
}

