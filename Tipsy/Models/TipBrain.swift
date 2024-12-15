//
//  TipBrain.swift
//  Tipsy
//
//  Created by Iliya Lyan on 12/15/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import UIKit

struct TipBrain {
    var tipRawValue: String?
    var tipDecimalValue: Float?
    var result: Float?
    var numberOfPeople: Int?
    
    mutating func getTipRawValue(value: UIButton?) -> String? {
        tipRawValue = value?.currentTitle?.components(separatedBy: "%")[0]
        
        return tipRawValue
    }
    
    mutating func getTipDecimalValue(value: String) {
        tipDecimalValue = Float(value)! / 100.0
    }
    
    mutating func calculateResult(total: Float, numberOfPeople: Float) {
        self.numberOfPeople = Int(numberOfPeople)
        result = (total + (total * (tipDecimalValue ?? 0.0))) / numberOfPeople
    }
}
