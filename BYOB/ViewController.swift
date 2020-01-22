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
import BLTNBoard

class ViewController: UIViewController {
    // On First Open
    var bulletinItem = BLTNPageItem(title: "Notifications")
    
    var bulletinExample = BLTNPageItem(title: "Example")
    
    lazy var bulletinManager: BLTNItemManager = {
        return BLTNItemManager(rootItem: bulletinItem)
    }()
    
    // ANALYTICS
    var graphView: UIView = {
        $0.backgroundColor = UIColor(hex: "#ddddddff")
        $0.layer.cornerRadius = 55.0
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
        $0.textColor = .black
        return $0
    } (UILabel())
    
    // MY PLAN
    var planView: UIView = {
        $0.backgroundColor = UIColor(hex: "#ddddddff")
        $0.layer.cornerRadius = 55.0
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
        $0.textColor = .black
        return $0
    } (UILabel())
    
    // EXPENSES
    var expenseView: UIView = {
        $0.backgroundColor = UIColor(hex: "#ddddddff")
        $0.layer.cornerRadius = 55.0
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
        $0.textColor = .black
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
    
    var progressView: UIView = {
        $0.backgroundColor = .clear
        return $0
    } (UIView())
    
    var daysRemainingLabel = UILabel()
    
    lazy var progressBarBackground: CAShapeLayer = {
        $0.fillColor = UIColor.clear.cgColor
        $0.strokeColor = UIColor.lightGray.cgColor
        $0.lineWidth = 10
        createProgressLayout(bezierIn: $0)
        $0.strokeStart = 0
        $0.strokeEnd = 1
        return $0
    } (CAShapeLayer())
    
    // FUNCTIONS
    func getCurrentMonth() -> String {
        let formatterMonth = DateFormatter()
        formatterMonth.dateFormat = "MMMM"
        let dateMonth = formatterMonth.string(from: Date())
        return dateMonth
    }
    
    func setDaysRemainingLabel() {
        let remaining = staticFunctions.getTotalMaxBudget() - staticFunctions.getTotalAmountSpent()
        var dailyRemaining = remaining
        if getDaysRemaining() != "0" {
        dailyRemaining = remaining / Double(getDaysRemaining())!
        }
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        let dailyRemainingString = formatter.string(from: NSNumber(value: dailyRemaining))
        daysRemainingLabel.text = "There are " + getDaysRemaining() + " days left in " + getCurrentMonth() + " (\(dailyRemainingString!) per day)"
        daysRemainingLabel.font = UIFont(name: "Avenir-Medium", size: 15.0)
        daysRemainingLabel.textColor = .black
    }
    
    func createProgressLayout(bezierIn: CAShapeLayer) {
        let yAxis: CGFloat
        let radiusIn: CGFloat
        radiusIn = UIScreen.main.bounds.height / 10
        let number = 210 / UIScreen.main.bounds.height
        print(number)
        yAxis = radiusIn + 4
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
        view.backgroundColor = UIColor(hex: "#cfffe5ff")
        
        view.addSubview(graphView)
        view.addSubview(planView)
//        view.addSubview(monthView)
        view.addSubview(daysRemainingLabel)
        
        view.addSubview(planLabel)
        view.addSubview(graphLabel)
        view.addSubview(expenseView)
        view.addSubview(expenseLabel)
        view.addSubview(progressView)
        
        progressView.layer.addSublayer(progressBarBackground)
        progressView.layer.addSublayer(progressBar)
        
        graphView.addSubview(graphButton)
        planView.addSubview(planButton)
        expenseView.addSubview(expenseButton)
        
        
        view.addSubview(monthHeader)
        setupConstraints()
        setupButtons()
        //view.bringSubviewToFront(monthView)
        setupBulletinBoard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setDaysRemainingLabel()
    }
    
    func setupButtons() {
        graphButton.addTarget(self, action: #selector(self.analyticsPressed), for: .touchUpInside)
        planButton.addTarget(self, action: #selector(self.myPlanPressed), for: .touchUpInside)
        expenseButton.addTarget(self, action: #selector(self.expensesPressed), for: .touchUpInside)
    }
    
    func hapticFeedback() {
        let heavyImpact = UIImpactFeedbackGenerator(style: .medium)
        heavyImpact.prepare()
        heavyImpact.impactOccurred()
    }
    
    @objc func analyticsPressed() {
        hapticFeedback()
        let analytics = AnalyticsController()
        navigationController?.pushViewController(analytics, animated: true)
//        self.present(analytics, animated: true, completion: nil)
    }
    
    @objc func myPlanPressed() {
        hapticFeedback()
        let myPlan = MyPlanController()
        self.navigationController?.pushViewController(myPlan, animated: true)
//        self.present(myPlan, animated: true, completion: nil)
    }
    
    @objc func expensesPressed() {
        hapticFeedback()
        let expenses = ExpensesController()
        self.navigationController?.pushViewController(expenses, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        var percentage = 0.0
        super.viewDidAppear(false)
        if staticFunctions.getTotalMaxBudget() != 0 {
            percentage = staticFunctions.getTotalAmountSpent() / staticFunctions.getTotalMaxBudget()
        }
        animateProgressBar(toPercentage: CGFloat(percentage))
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
//            self.animateProgressBar(toPercentage: 0.7)
//        }
        bulletinManager.showBulletin(above: self)
    }
    
    func animateProgressBar(toPercentage percentage: CGFloat) {
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
    
    func setupBulletinBoard() {
        bulletinItem.image = UIImage(named: "push")
        bulletinItem.descriptionText = "Do you want to enable push notifications for this app? I won't be obnoxious :)"
        bulletinItem.actionButtonTitle = "Of freaking course"
        bulletinItem.alternativeButtonTitle = "Pfft nope"
        bulletinItem.appearance.actionButtonColor = UIColor(hex: "#F84A46FF")!
        bulletinItem.appearance.alternativeButtonTitleColor = UIColor(hex: "#F84A46FF")!
        bulletinItem.appearance.titleTextColor = UIColor(hex: "#F84A46FF")!
        bulletinItem.isDismissable = false
        bulletinItem.next = bulletinExample
        bulletinItem.actionHandler = { (item: BLTNActionItem) in
            self.requestNotificationAuthorization()
            self.bulletinManager.displayNextItem()
        }
        bulletinItem.alternativeHandler = { (item: BLTNActionItem) in
            self.bulletinManager.displayNextItem()
        }
        
    }
    
    func setupConstraints() {
        
        // GRAPH
        graphView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-75)
            make.height.width.equalTo(110)
            make.top.equalTo(planView.snp.top)
            
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
            make.centerX.equalToSuperview().offset(75)
            make.height.width.equalTo(110)
            make.top.equalTo(daysRemainingLabel.snp.bottom).offset(4)
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
            make.top.equalTo(planView.snp.bottom).offset(40)
            make.centerX.equalToSuperview().offset(-75)
            make.height.width.equalTo(110)
        }
        
        expenseButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        expenseLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-80)
            make.top.equalTo(expenseView.snp_bottom).offset(4)
            make.height.equalTo(20)
        }
        
        monthHeader.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        progressView.snp.makeConstraints { (make) in
            make.top.equalTo(monthHeader.snp.bottom)
            make.height.equalTo(UIScreen.main.bounds.height / 5 + 16)
            make.left.right.equalToSuperview()
        }
        
        daysRemainingLabel.snp.makeConstraints { (make) in
            make.top.equalTo(progressView.snp.bottom)
            make.bottom.equalTo(planView.snp.top).offset(-4)
            make.centerX.equalToSuperview()
        }
        
        
//        planButton.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
    }
    
    
}

