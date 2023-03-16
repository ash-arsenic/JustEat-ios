//
//  RestrauntItems.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 06/03/23.
//

import SwiftUI

struct RestrauntItems: View {
    var restraunt: Restraunt
    var foods: [Food]
    @EnvironmentObject var settings: UserSettings
    @State private var addedToCart = false
    @State private var showCartNotEmptyAlert = false
    @State private var currentItemId: String = "0"
    
    @State private var qunatity = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    @State private var cartItems: [Cart] = []
    var body: some View {
        List {
            HStack {
                VStack(alignment: .leading) {
                    Text(restraunt.name!)
                        .font(.title.weight(.bold))
                    Text(getCategory(restraunt.category!))
                    Text(restraunt.address!).foregroundColor(Color.gray).font(.callout)
                    HStack {
                        Image(systemName: "stopwatch")
                        Text("\(getEstimatedTime(restraunt.distance!)) | \(restraunt.distance!) km away")
                    }.font(.callout.weight(.semibold))
                }
                Spacer()
                VStack {
                    HStack {
                        Text("\(restraunt.rating!)").foregroundColor(.white)
                            .font(.title3.weight(.semibold))
                    }
                    .padding(.horizontal).padding(.vertical, 8)
                    .background(Color(hue: 0.272, saturation: 0.927, brightness: 0.488))
                    VStack {
                        Text(getTotalReviews(foods))
                            .font(.subheadline.weight(.semibold))
                        Text("Reviews").foregroundColor(Color.gray)
                            .font(.caption)
                            .padding(.horizontal, 8)
                    }
                }.cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black.opacity(0.3), lineWidth: 1))
            }.contentShape(Rectangle())
            .onTapGesture {
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .listRowSeparator(.hidden)
            .shadow(radius: 6)
            
            ForEach(foods, id: \.id) { dish in
                DishRow(showCartNotEmptyAlert: $showCartNotEmptyAlert, currentFoodItemId: $currentItemId, distance: restraunt.distance!, restrauntId: String(restraunt.id!),food: dish, itemQuanity: qunatity[dish.id! - 1], incrementAction: {
                        updateCartItems(id: String(dish.id!), inc: true)
                    }, decrementAction: {
                        updateCartItems(id: String(dish.id!), inc: false)
                    }, addBtnAction: {
                        addToCart()
                    })
            }
        }.listStyle(.plain)
        .padding(.top, 2)
        .navigationBarTitle("Restraunt Items")
        .onAppear() {
            if settings.user.restrauntId == String(restraunt.id!) {
                if let items = settings.user.cartItem?.allObjects as? [Cart] {
                    self.cartItems = items
                    for item in self.cartItems {
                        qunatity[Int(item.cartId!)! - 1] = Int(exactly: item.quantity)!
                    }
                }
                
            }
        }
        .overlay {
            if showCartNotEmptyAlert {
                VStack {
                    VStack{
                        Image("EmptyCart").resizable().frame(width: 100, height: 100)
                        Text("There are already items added in a cart from different restaurant")
                            .fontWeight(.bold)
                            .font(.headline)
                        Text("Do you want to remove it?")
                            .font(.body)
                            .fontWeight(.semibold)
                        HStack{
                            Button(action: {
                                showCartNotEmptyAlert = false
                            }, label: {
                                Text("Cancel")
                            }).padding().frame(width: 130, height: 50)
                                .foregroundColor(Color("PrimaryColor")).overlay {
                                    RoundedRectangle(cornerRadius: 15, style: .continuous).stroke(Color("PrimaryColor"),lineWidth: 3)
                                }.background(Color("SecondaryColor")).cornerRadius(15)
                            Button(action: {
                                showCartNotEmptyAlert = false
                                removerFromCart()
                            }, label: {
                                Text("Empty Cart")
                            }).padding().frame(width: 130, height: 50)
                                .foregroundColor(Color("PrimaryColor")).overlay {
                                    RoundedRectangle(cornerRadius: 15, style: .continuous).stroke(Color("PrimaryColor"),lineWidth: 3)
                                }.background(Color("SecondaryColor")).cornerRadius(15)
                        }
                    }.padding(8)
                        .background(.white)
                        .cornerRadius(25).frame(width: UIScreen.main.bounds.width*0.85).overlay {
                        RoundedRectangle(cornerRadius: 25, style: .continuous).stroke(Color(.gray), lineWidth: 1)
                    }
                }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .background(Color.black.opacity(0.1))
            }
        }
    }
    
    func removerFromCart() {
        settings.user.cartItem = []
        settings.user.restrauntId = String(restraunt.id!)
        addToCart()
    }
    func updateCartItems(id: String, inc: Bool) {
        var ind: Int = 0
        for i in 0..<cartItems.count {
            if cartItems[i].cartId == id {
                ind = i
                break
            }
        }
        
        if inc {
            cartItems[ind].quantity = cartItems[ind].quantity + 1
            qunatity[Int(currentItemId)! - 1] += 1
        } else {
            if qunatity[Int(currentItemId)! - 1] == 1 {
                deleteCartItem(id: currentItemId)
                qunatity[Int(currentItemId)! - 1] -= 1
            } else {
                cartItems[ind].quantity = cartItems[ind].quantity - 1
                qunatity[Int(currentItemId)! - 1] -= 1
            }
        }
        PersistenceController.shared.save()
        settings.refreshCart()
    }
    
    
    func deleteCartItem(id: String) {
        var ind = -1
        for i in 0..<cartItems.count {
            if(cartItems[i].cartId == id) {
                ind = i
                break
            }
        }
        if ind != -1 {
            PersistenceController.shared.deleteCartItem(item: cartItems[ind])
            cartItems.remove(at: ind)
            settings.user.cartItem?.adding(cartItems)
            settings.setCartItems(items: cartItems)
            PersistenceController.shared.save()
        } else {
            print("ID not found")
        }
    }
    
    
    func addToCart() {
        for food in foods {
            if String(food.id!) == currentItemId {
                if (settings.user.cartItem?.count == 0 || String(restraunt.id!) == settings.user.restrauntId ?? "0") {
                    qunatity[Int(currentItemId)! - 1] += 1
                    settings.user.restrauntId = String(restraunt.id!)
                    PersistenceController.shared.saveCartItem(data: ["name": food.name!, "veg": food.isVeg!, "price": food.price!, "user": settings.user, "distance": restraunt.distance!, "restrauntId": String(restraunt.id!), "cartId": String(food.id!)])
                    if let items = settings.user.cartItem?.allObjects as? [Cart] {
                        self.cartItems = items
                    }
                } else {
                    showCartNotEmptyAlert = true
                }
            }
        }
    }
    func getTotalReviews(_ dishes: [Food]) -> String {
        var sum = 0
        for dish in dishes {
            sum += Int(dish.totalVotes!)!
        }
        return String(sum)
    }
    
    func getEstimatedTime(_ distance: String) -> String {
        let t = 10 + (Int(distance)! * 5)
        return "\(t) - \(t+5) min"
    }
    
    func getCategory(_ category: String) -> String {
        switch(category) {
        case "1":
            return "North Indian"
        case "2":
            return "South Indian"
        case "3":
            return "Pizza & Burgers"
        case "4":
            return "Desert"
        case "5":
            return "Chinese"
        case "6":
            return "Starters"
        default:
            return "El Gurerro"
        }
    }
}

struct RestrauntItems_Previews: PreviewProvider {
    static var previews: some View {
        RestrauntItems(restraunt: Restraunt(data: [
            "D": false,
            "F": "3",
            "G": "250",
            "H": true,
            "I": "Huntersville, North Carolina, United States",
            "id": 1,
            "col1": "2",
            "rating": "⭐️",
            "fullName": "Sagar Ratna",]), foods: [Food(data: [
                "D": "Shakes",
                    "E": "150",
                    "G": "https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fmilk-shake&psig=AOvVaw1O74IwZJMMMQ9jD_LOhePZ&ust=1678262309447000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCMip_7esyf0CFQAAAAAdAAAAABAZ",
                    "id": 1,
                    "col1": "⭐️⭐️⭐️⭐️⭐️",
                    "col2": "sweet beverage made by blending milk, ice cream, and flavorings or sweeteners such as butterscotch, caramel sauce, chocolate syrup, fruit syrup, or whole fruit into a thick, sweet, cold mixture.",
                    "col3": "250",
                    "isUser": true
            ])])
    }
}
