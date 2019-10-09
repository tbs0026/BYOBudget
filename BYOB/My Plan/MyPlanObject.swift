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
    var amount: Double
    var monthlyItem: Bool
    var dateEdited = Date()
    var epoch = String()
    
    init(titleIn: String, amountIn: Double, monthly: Bool, epochIn: String) {
        self.title = titleIn
        self.amount = amountIn
        self.monthlyItem = monthly
        self.dateEdited = Date()
        self.epoch = epochIn
    }
    
    
}
