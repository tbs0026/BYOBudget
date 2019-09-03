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
    var title: UILabel = {
        $0.font = UIFont(name: "Avenir-HeavyOblique", size: 16)
        return $0
    } (UILabel())
    
    var amount: UILabel = {
        $0.font = UIFont(name: "Avenir-MediumOblique", size: 14)
        return $0
    } (UILabel())
    
    static let reuse = "MyPlanCell"
    
    func setupCell(titleIn: String, amountIn: Double) {
        self.backgroundColor = UIColor(hex: "#ffffffff")
        amount.text = String(amountIn)
        title.text = titleIn
        setupConstraints()
        self.contentView.addSubview(title)
    }
    
    func setupVariables() {
    }
    
    func setupConstraints() {
        title.snp.makeConstraints { (make) in
            make.centerY.left.equalToSuperview().inset(4)
            make.height.equalTo(20)
        }
        
        title.snp.makeConstraints { (make) in
            make.centerY.right.equalToSuperview().inset(4)
            make.height.equalTo(20)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
