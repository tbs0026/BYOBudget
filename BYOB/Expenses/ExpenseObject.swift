//
//  ExpenseObject.swift
//  BYOB
//
//  Created by Trevor Smith on 1/27/20.
//  Copyright © 2020 Trevor Smith. All rights reserved.
//

import SwiftDate

class ExpenseObject: Codable {
    var title: String
    var category: String
    var dateEdited = Date()
    var epoch = String()
    var amountSpent: Double
    
    init(titleIn: String, amountIn: Double, epochIn: String, categoryIn: String) {
        self.title = titleIn
        self.amountSpent = amountIn
        self.epoch = epochIn
        self.category = categoryIn
    }
}
