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
    
    var body: some View {
        List {
            HStack() {
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
                    }
                }.cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black.opacity(0.3), lineWidth: 1))
            }.padding()
            .background(Color.white)
            .cornerRadius(15)
            .listRowSeparator(.hidden)
            .shadow(radius: 6)

            ForEach(foods, id: \.id) { dish in
                DishRow(distance: restraunt.distance!,food: dish)
            }
        }.listStyle(.plain)
            .padding(.top, 2)
        
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
