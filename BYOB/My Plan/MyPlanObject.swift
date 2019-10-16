//
//  MyPlanObject.swift
//  BYOB
//
//  Created by Trevor Smith on 9/3/19.
//  Copyright © 2019 Trevor Smith. All rights reserved.
//
import UIKit
import SwiftDate

class MyPlanObject: Codable {
    var title: String
    var maxAmount: Double
    var monthlyItem: Bool
    var dateEdited = Date()
    var epoch = String()
    var amountSpent: Double
    
    init(titleIn: String, maxAmountIn: Double, monthly: Bool, amountSpentIn: Double, epochIn: String) {
        self.title = titleIn
        self.maxAmount = maxAmountIn
        self.monthlyItem = monthly
        self.dateEdited = Date()
        self.amountSpent = amountSpentIn
        self.epoch = epochIn
    }
    
    
}
