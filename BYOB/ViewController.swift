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
    
    lazy var monthHeader: UILabel = {
        $0.text = getCurrentMonth()
        $0.textColor = .black
        $0.font = UIFont(name: "Avenir-Heavy", size: 50.0)
        $0.alpha = 1.0
        return $0
    } (UILabel())
    
    var monthView: UIView = {
        $0.backgroundColor = .clear
        return $0
    } (UIView())
    
    lazy var daysRemainingLabel: UILabel = {
        $0.text = "There are " + getDaysRemaining() + " days left in " + getCurrentMonth() + " ($" + " per day)"
        $0.font = UIFont(name: "Avenir-Medium", size: 15.0)
        return $0
    } (UILabel())
    
    func getCurrentMonth() -> String {
        let formatterMonth = DateFormatter()
        formatterMonth.dateFormat = "MMMM"
        let dateMonth = formatterMonth.string(from: Date())
        return dateMonth
    }
    
    func daysPerMonth() -> Int {
        let formatterMonth = DateFormatter()
        formatterMonth.dateFormat = "MMMM"
        let dateMonth = formatterMonth.string(from: Date())
        var daysRemaining: Int
        switch dateMonth {
        case "January", "March", "May", "July", "August", "October", "December":
            daysRemaining = 31
        case "February":
            daysRemaining = 28
        default:
            daysRemaining = 30
        }
        return daysRemaining
    }
    
    func getDaysRemaining() -> String {
        
        let daysInCurrentMonth = daysPerMonth()
        let formatterDay = DateFormatter()
        formatterDay.dateFormat = "dd"
        let currentDayString = formatterDay.string(from: Date())
        let currentDayInt = Int(currentDayString)
        let difference = daysInCurrentMonth - currentDayInt!
        return "\(difference)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "#cfffe5ff")
        view.addSubview(graphView)
        view.addSubview(planView)
        view.addSubview(monthView)
        view.addSubview(daysRemainingLabel)
        graphView.addSubview(graphButton)
        planView.addSubview(planButton)
        monthView.addSubview(monthHeader)
        setupConstraints()
        view.bringSubviewToFront(monthView)
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
        
        monthView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            if UIDevice.modelName.contains("X") || UIDevice.modelName.contains("Plus") {
                make.height.equalTo(190)
            } else {
                make.height.equalTo(150)
            }
        }
        
        monthHeader.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        daysRemainingLabel.snp.makeConstraints { (make) in
            make.top.equalTo(monthView.snp_bottom)
            make.centerX.equalToSuperview()
        }
        
//        planButton.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
    }
    
    
}

