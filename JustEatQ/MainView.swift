//
//  MainView.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 21/02/23.
//

import SwiftUI

struct MainView: View {
    @State private var tabSelected = 0
    @StateObject var apiData = ApiData()
    @State private var dataLoaded = 0
    
    var body: some View {
        if dataLoaded >= 2{
            TabView(selection: $tabSelected) {
                DeliveryView(apiData: apiData, restraunts: apiData.restraunts)
                    .tabItem {
                        Label("Delivery", systemImage: "bicycle")
                    }.tag(0)
                GroceryView()
                    .tabItem {
                        Label("Grocery", systemImage: "basket.fill")
                    }.tag(1)
                CartView(selection: $tabSelected)
                    .tabItem {
                        Label("Cart", systemImage: "cart.fill")
                    }.tag(2)
            }.padding(.top, 50)
            .overlay(JENavidationBar())
        } else {
            ProgressView("Fetching Data")
            .onAppear() {
                NetworkManager.shared.requestForApi(url: "https://retoolapi.dev/upVf9f/data", completionHandler: { data in
                    guard let data = data as? [[String: Any]] else {return}
                    let restraunts: [Restraunt] = data.map{Restraunt(data: $0)}
                    apiData.setRestraunts(restraunts: restraunts)
                    dataLoaded += 1
                })
                NetworkManager.shared.requestForApi(url: "https://retoolapi.dev/K9ecdS/akadbakadbambeboaasinabepureso", completionHandler: { data in
                    guard let data = data as? [[String: Any]] else {return}
                    let foods: [Food] = data.map{Food(data: $0)}
                    apiData.setFoods(foods: Array(foods[0...19]))
                    dataLoaded += 1
                    
                })
            }
        }
//      https://retoolapi.dev/upVf9f/data (Restraunt) https://retoolapi.dev/K9ecdS/akadbakadbambeboaasinabepureso (Dish)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
