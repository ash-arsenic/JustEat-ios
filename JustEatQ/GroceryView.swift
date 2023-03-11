//
//  GroceryView.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 21/02/23.
//

import SwiftUI

struct GroceryView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Text("Groceries in minutes!")
                    .font(.system(size: 30))
                    .fontWeight(.heavy)
                    .padding(10)
                
                Image("GroceryMap")
                    .resizable()
                    .scaledToFill()
                    .frame(height: UIScreen.main.bounds.height * 0.25)
                    .padding(.horizontal, -12)
                
                VStack {
                    Image("BlinkitIcon")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .padding(12)
                    
                    Text("India's Last Minute App")
                        .font(.title2)
                        .fontWeight(.bold)
                    HStack {
                        Text("Get up to")
                        Text("₹100 OFF").fontWeight(.bold)
                        Text("&")
                        Text("free delivery").fontWeight(.bold)
                    }.padding(.vertical, 2).font(.headline.weight(.regular))
                    HStack {
                        Text("Use code")
                        Text("WELCOME100").padding(.horizontal, -2)
                            .foregroundColor(Color("GroceryColor1"))
                        Text("on your first order")
                    }.padding(.bottom, 12).font(.caption)
                    
                    Button(action: {
                        
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Open Blinkit app")
                                .font(.title3)
                            Image(systemName: "arrowshape.right.fill")
                                .padding(6)
                                .font(.caption.weight(.light))
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            Spacer()
                        }
                    }).padding(.horizontal, 20).padding(.vertical, 10)
                    .contentShape(Rectangle())
                    .frame(maxWidth: .infinity)
                    .background(Color("GroceryColor1"))
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    
                    Label("App already installed", systemImage: "checkmark")
                        .font(.subheadline)
                        .foregroundColor(Color("GroceryColor1"))
                }
                .padding(20)
                .overlay {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(Color("LightGray"), lineWidth: 1)
                }
                .background(Color("GroceryColor2"))
                
                HStack {
                    Image(systemName: "star.fill")
                        .font(.caption2)
                    Text("ENJOY THESE BENEFITS")
                        .font(.callout)
                        .kerning(4)
                    Image(systemName: "star.fill")
                        .font(.caption2)
                }.padding(.top, 36).padding(.bottom, 24)
                GroceryList("GroceryIcon1", "Enjoy 500+ products to suit", "your needs")
                    .padding(.bottom, 12)
                GroceryList("GroceryIcon2", "Everything Delivered", "in minutes")
                    .padding(.bottom, 12)
                GroceryList("GroceryIcon3", "Amazing payment and", "bank offers")
            }.padding(12)
        }
    }
}

struct GroceryView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryView()
    }
}
