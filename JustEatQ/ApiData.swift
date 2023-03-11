//
//  ApiData.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 09/03/23.
//

import Foundation

class ApiData: ObservableObject {
    @Published var restraunts: [Restraunt]
    @Published var foods: [Food]
    
    init() {
        restraunts = []
        foods = []
    }
    
    init(restraunts: [Restraunt], foods: [Food]) {
        self.restraunts = restraunts
        self.foods = foods
    }
    
    func setRestraunts(restraunts: [Restraunt]) {
        self.restraunts = restraunts
    }
    
    func setFoods(foods: [Food]) {
        self.foods = foods
    }
}
