//
//  MyPlanObject.swift
//  BYOB
//
//  Created by Trevor Smith on 9/3/19.
//  Copyright © 2019 Trevor Smith. All rights reserved.
//

class MyPlanObject {
    var title: String
    
    var amount: Double
    
    init(titleIn: String, amountIn: Double) {
        title = titleIn
        amount = amountIn
    }
    
    func setTitle(titleIn: String) {
        title = titleIn
    }
    
    func setAmount(amountIn: Double) {
        amount = amountIn
    }
}
