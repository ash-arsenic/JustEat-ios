//
//  MainView.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 21/02/23.
//

import SwiftUI

struct MainView: View {
    @State private var tabSelected = 0
    var body: some View {
        NavigationView {
            TabView(selection: $tabSelected) {
                DeliveryView()
                    .tabItem {
                        Label("Delivery", systemImage: "bicycle")
                    }.tag(0)
                GroceryView()
                    .tabItem {
                        Label("Grocery", systemImage: "apple.logo")
                    }.tag(1)
                CartView(selection: $tabSelected)
                    .tabItem {
                        Label("Cart", systemImage: "cart.fill")
                    }.tag(2)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
