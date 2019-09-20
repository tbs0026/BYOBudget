//
//  MyPlanCell.swift
//  BYOB
//
//  Created by Trevor Smith on 9/3/19.
//  Copyright © 2019 Trevor Smith. All rights reserved.
//

import UIKit
import SnapKit

class MyPlanCell: UITableViewCell {
    
    static let reuse = "MyPlanCell"
    
    let card: UIView = {
        $0.backgroundColor = UIColor(hex: "#ffffffff")
        $0.layer.cornerRadius = 12
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.7
        $0.layer.shadowRadius = 3
        return $0
    }(UIView())
    
//    init(titleIn: String, amountIn: Double) {
//        super.init(style: .default, reuseIdentifier: "MyPlanCell")
//        setupCell(titleIn: titleIn, amountIn: amountIn)
//    }
    
    var title: UILabel = {
        $0.font = UIFont(name: "Avenir-HeavyOblique", size: 16)
        return $0
    } (UILabel())
    
    var amount: UILabel = {
        $0.font = UIFont(name: "Avenir-MediumOblique", size: 14)
        return $0
    } (UILabel())
    
    func setupCell(titleIn: String, amountIn: Double) {
        self.backgroundColor = UIColor(hex: "#eeeeeeff")
        amount.text = String(amountIn)
        title.text = titleIn

        addSubview(card)
        card.addSubview(self.title)
        card.addSubview(self.amount)
        card.snp.removeConstraints()
        card.subviews.forEach { $0.snp.removeConstraints() }
        setupConstraints()
        
    }
    
    func setupVariables() {
    }
    
    func setupConstraints() {
        card.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(8)
            
        }
        
        title.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(4)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
        
        amount.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(4)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
        
    }
}
