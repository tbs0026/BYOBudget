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
    
    // ANALYTICS
    var graphView: UIView = {
        $0.backgroundColor = UIColor(hex: "#ddddddff")
        if UIDevice.modelName.contains("X") || UIDevice.modelName.contains("Plus") {
            $0.layer.cornerRadius = 60.0
        } else {
            $0.layer.cornerRadius = 50.0
        }
        return $0
    } (UIView())
    
    var graphButton: UIButton = {
        $0.alpha = 1.0
        $0.setImage(#imageLiteral(resourceName: "bars"), for: UIControl.State.normal)
        return $0
    } (UIButton())
    
    var graphLabel: UILabel = {
        $0.text = "Analytics"
        $0.font = UIFont(name: "Avenir-Light", size: 20.0)
        return $0
    } (UILabel())
    
    // MY PLAN
    var planView: UIView = {
        $0.backgroundColor = UIColor(hex: "#ddddddff")
        if UIDevice.modelName.contains("X") || UIDevice.modelName.contains("Plus") {
            $0.layer.cornerRadius = 60.0
        } else {
            $0.layer.cornerRadius = 50.0
        }
        return $0
    } (UIView())
    
    var planButton: UIButton = {
        $0.alpha = 1.0
        $0.setImage(#imageLiteral(resourceName: "form"), for: UIControl.State.normal)
        return $0
    } (UIButton())
    
    var planLabel: UILabel = {
        $0.text = "My Plan"
        $0.font = UIFont(name: "Avenir-Light", size: 20.0)
        return $0
    } (UILabel())
    
    // EXPENSES
    var expenseView: UIView = {
        $0.backgroundColor = UIColor(hex: "#ddddddff")
        if UIDevice.modelName.contains("X") || UIDevice.modelName.contains("Plus") {
            $0.layer.cornerRadius = 60.0
        } else {
            $0.layer.cornerRadius = 50.0
        }
        return $0
    } (UIView())
    
    var expenseButton: UIButton = {
        $0.alpha = 1.0
        $0.setImage(#imageLiteral(resourceName: "form"), for: UIControl.State.normal)
        return $0
    } (UIButton())
    
    var expenseLabel: UILabel = {
        $0.text = "Expenses"
        $0.font = UIFont(name: "Avenir-Light", size: 20.0)
        return $0
    } (UILabel())
    
    // HEADER
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
    
    lazy var progressBar: CAShapeLayer = {
        $0.fillColor = UIColor.clear.cgColor
        $0.strokeColor = UIColor.green.cgColor
        $0.lineWidth = 10
        $0.lineCap = .round
        createProgressLayout(bezierIn: $0)
        $0.strokeStart = 0
        $0.strokeEnd = 0.02
        return $0
    } (CAShapeLayer())
    
    lazy var progressBarBackground: CAShapeLayer = {
        $0.fillColor = UIColor.clear.cgColor
        $0.strokeColor = UIColor.lightGray.cgColor
        $0.lineWidth = 10
        createProgressLayout(bezierIn: $0)
        $0.strokeStart = 0
        $0.strokeEnd = 1
        return $0
    } (CAShapeLayer())
    
    lazy var daysRemainingLabel: UILabel = {
        $0.text = "There are " + getDaysRemaining() + " days left in " + getCurrentMonth() + " ($" + " per day)"
        $0.font = UIFont(name: "Avenir-Medium", size: 15.0)
        return $0
    } (UILabel())
    
    // FUNCTIONS
    func getCurrentMonth() -> String {
        let formatterMonth = DateFormatter()
        formatterMonth.dateFormat = "MMMM"
        let dateMonth = formatterMonth.string(from: Date())
        return dateMonth
    }
    
    func createProgressLayout(bezierIn: CAShapeLayer) {
        let yAxis: CGFloat
        let radiusIn: CGFloat
        if UIDevice.modelName.contains("Plus") {
            yAxis = 190
            radiusIn = 50
        } else if UIDevice.modelName.contains("X") {
            yAxis = 220
            radiusIn = 70
        } else {
            yAxis = 150
            radiusIn = 40
        }
        let xAxis: CGFloat = UIScreen.main.bounds.width/2
        let center = CGPoint(x: xAxis, y: yAxis)
        let circularPath = UIBezierPath(arcCenter: center, radius: radiusIn, startAngle: -CGFloat.pi / 2, endAngle: 3 / 2 * CGFloat.pi, clockwise: true)
        bezierIn.path = circularPath.cgPath
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
        
        view.addSubview(planLabel)
        view.addSubview(graphLabel)
        view.addSubview(expenseView)
        view.addSubview(expenseLabel)
        
        view.layer.addSublayer(progressBarBackground)
        view.layer.addSublayer(progressBar)
        
        graphView.addSubview(graphButton)
        planView.addSubview(planButton)
        expenseView.addSubview(expenseButton)
        
        
        monthView.addSubview(monthHeader)
        setupConstraints()
        //view.bringSubviewToFront(monthView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        animateProgressBar(toPercentage: 0.75)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
//            self.animateProgressBar(toPercentage: 0.7)
//        }
    }
    
    func animateProgressBar(toPercentage percentage: CGFloat) {
        print("print")
        let fromValue = progressBar.strokeEnd
        progressBar.strokeEnd = percentage
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = fromValue
        animation.toValue = percentage //+ 0.02
        animation.duration = 2
        let bounce = CABasicAnimation(keyPath: "strokeEnd")
        bounce.fromValue = percentage + 0.02
        bounce.toValue = percentage
        
        let group = CAAnimationGroup()
        group.animations = [animation, bounce]
        progressBar.add(animation, forKey: "animateStroke")
    }
    
    func setupConstraints() {
        
        // GRAPH
        graphView.snp.makeConstraints { (make) in
            if UIDevice.modelName.contains("X") || UIDevice.modelName.contains("Plus") {
                make.centerX.equalToSuperview().inset(-80)
                make.centerY.equalToSuperview().offset(-30)
                make.height.width.equalTo(120)
            } else {
                make.centerX.equalToSuperview().inset(-70)
                make.centerY.equalToSuperview().offset(-20)
                make.height.width.equalTo(100)
                
            }
            
        }
        
        graphButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        graphLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-80)
            make.top.equalTo(graphView.snp_bottom).offset(4)
            make.height.equalTo(20)
        }
        
        // MY PLAN
        planView.snp.makeConstraints { (make) in
            if UIDevice.modelName.contains("X") || UIDevice.modelName.contains("Plus") {
                make.centerX.equalToSuperview().offset(80)
                make.centerY.equalToSuperview().offset(-30)
                make.height.width.equalTo(120)
            } else {
                make.centerX.equalToSuperview().offset(70)
                make.centerY.equalToSuperview().offset(-20)
                make.height.width.equalTo(100)
            }
        }
        
        planButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        planLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(80)
            make.top.equalTo(planView.snp_bottom).offset(4)
            make.height.equalTo(20)
        }
        
        // EXPENSES
        expenseView.snp.makeConstraints { (make) in
            if UIDevice.modelName.contains("X") || UIDevice.modelName.contains("Plus") {
                make.centerX.equalToSuperview().offset(-80)
                make.centerY.equalToSuperview().offset(130)
                make.height.width.equalTo(120)
            } else {
                make.centerX.equalToSuperview().offset(-70)
                make.centerY.equalToSuperview().offset(120)
                make.height.width.equalTo(100)
            }
        }
        
        expenseButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        expenseLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-80)
            make.top.equalTo(expenseView.snp_bottom).offset(4)
            make.height.equalTo(20)
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
            make.bottom.equalTo(planView.snp_top).offset(-4)
            make.centerX.equalToSuperview()
        }
        
//        planButton.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
    }
    
    
}

