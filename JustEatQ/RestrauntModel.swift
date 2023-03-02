//
//  RestrauntModel.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 01/03/23.
//

import Foundation

struct Restraunt {
    var name: String
    var category: [String]
    var ratings: Double
    var distance: Double
    var dishes: [Food]
    
    func getEstimatedTime() -> String {
        let time = 10 + Int(distance * 4)
        return ("\(time) - \(time+5) min")
    }
}

struct Food {
    var name: String
    var price: Double
}
