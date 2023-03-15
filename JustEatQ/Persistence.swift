//
//  Persistence.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 20/02/23.
//

import CoreData

class PersistenceController {
    
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext

    init() {
        container = NSPersistentContainer(name: "JustEatQ")
        context = container.viewContext
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("Error")
        }
    }
    
    func saveUser(data: [String: String]) {
        let user = User(context: context)
        user.email = data["email"]
        user.name = data["name"]
        user.password = data["password"]
        user.dob = data["dob"]
        save()
    }
    
    func saveCartItem(data: [String: Any]) {
        let cart = Cart(context: context)
        cart.cartId = UUID()
        cart.name = data["name"] as? String
        cart.quantity = 1
        cart.isVeg = (data["veg"] as? Bool)!
        cart.price = data["price"] as? String
        cart.user = data["user"] as? User
        cart.distance = data["distance"] as? String
        save()
    }
    
    func deleteCartItem(item: Cart) {
        context.delete(item)
        save()
    }
}
