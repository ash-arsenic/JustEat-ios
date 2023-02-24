//
//  MainView.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 21/02/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            TabView {
                DeliveryView()
                    .tabItem {
                        Label("Delivery", systemImage: "bicycle")
                    }
                GroceryView()
                    .tabItem {
                        Label("Grocery", systemImage: "apple.logo")
                    }
                CartView()
                    .tabItem {
                        Label("Cart", systemImage: "cart.fill")
                    }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
