//
//  HotelModel.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 07/03/23.
//


import Foundation

class Restraunt: ObservableObject {
    var isVeg: Bool?
    var distance: String?
    var price: String?
    var isLiked: Bool?
    var id: Int?
    var address: String?
    var rating: String?
    var name: String?
    var category: String?
    
    init(data: [String: Any]) {
        if let isVeg = data["D"] as? Bool {
            self.isVeg = Bool(isVeg)
        }
        if let distance = data["F"] as? String {
            self.distance = String(distance)
        }
        if let price = data["G"] as? String {
            self.price = String(price)
        }
        if let isLiked = data["H"] as? Bool {
            self.isLiked = Bool(isLiked)
        }
        if let category = data["col1"] as? String {
            self.category = String(category)
        }
        if let name = data["fullName"] as? String {
            self.name = String(name)
        }
        if let id = data["id"] as? Int {
            self.id = Int(id)
        }
        if let rating = data["rating"] as? String {
            self.rating = String(rating)
        }
        if let address = data["I"] as? String {
            self.address = String(address)
        }
    }
}
