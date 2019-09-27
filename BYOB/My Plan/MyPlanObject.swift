//
//  MyPlanObject.swift
//  BYOB
//
//  Created by Trevor Smith on 9/3/19.
//  Copyright © 2019 Trevor Smith. All rights reserved.
//
import UIKit
import SwiftDate

class MyPlanObject {
    var title: String
    var epoch: String
    var amount: Double
    
    init(titleIn: String, amountIn: Double) {
        title = titleIn
        amount = amountIn
        epoch = Date().timeIntervalSince1970.toString()
    }
    
    func setTitle(titleIn: String) {
        title = titleIn
    }
    
    func setAmount(amountIn: Double) {
        amount = amountIn
    }
    
    func setEpoch(epochIn: String) {
        epoch = epochIn
    }
}
