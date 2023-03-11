//
//  DishModel.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 07/03/23.
//

import Foundation

class Food: ObservableObject {
    var name: String?
    var price: String?
    var rating: String?
    var id: Int?
    var image: String?
    var description: String?
    var totalVotes: String?
    var isVeg: Bool?
    
    init(data: [String: Any]) {
        if let isVeg = data["isUser"] as? Bool {
            self.isVeg = Bool(isVeg)
        }
        if let price = data["col3"] as? String {
            self.price = String(price)
        }
        if let rating = data["col1"] as? String {
            self.rating = String(rating)
        }
        if let image = data["G"] as? String {
            self.image = String(image)
        }
        if let id = data["id"] as? Int {
            self.id = Int(id)
        }
        if let name = data["D"] as? String {
            self.name = String(name)
        }
        if let description = data["col2"] as? String {
            self.description = String(description)
        }
        if let totalVotes = data["E"] as? String {
            self.totalVotes = String(totalVotes)
        }
    }
}
