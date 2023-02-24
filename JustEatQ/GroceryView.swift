//
//  GroceryView.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 21/02/23.
//

import SwiftUI

struct GroceryView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Groceries in minutes!")
                    .font(.system(size: 32))
                    .fontWeight(.black)
                    .padding(10)
                
                Image("GroceryMap")
                    .resizable()
                    .scaledToFill()
                    .frame(height: UIScreen.main.bounds.height * 0.25)
                    .padding(.horizontal, -12)
                
                VStack {
                    Image("BlinkitIcon")
                        .resizable()
                        .frame(width: 100, height: 100)
                    
                    Text("India's Last Minute App")
                        .font(.title2)
                        .fontWeight(.black)
                    HStack {
                        Text("Get").font(.title3)
                        Text("₹100 OFF").font(.title3)
                            .fontWeight(.bold)
                        Text("&").font(.title3)
                        Text("free delivery").font(.title3)
                            .fontWeight(.bold)
                    }.padding(.vertical, 2)
                    HStack {
                        Text("Use code").font(.subheadline)
                        Text("WELCOME100").font(.subheadline)
                            .foregroundColor(Color("GroceryColor1"))
                        Text("on your first order").font(.subheadline)
                    }.padding(.bottom, 12)
                    
                    Button(action: {
                        
                    }, label: {
                        HStack {
                            Text("Open Blinkit app")
                                .font(.title)
                            Image(systemName: "arrowshape.right.fill")
                                .padding(6)
                                .font(.callout)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        }
                    }).padding(.horizontal, 20)
                        .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color("GroceryColor1"))
                    .cornerRadius(15)
                    .foregroundColor(.white)
                    
                    Label("App already installed", systemImage: "checkmark")
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
                        .font(.title3)
                        .kerning(2)
                    Image(systemName: "star.fill")
                        .font(.caption2)
                }.padding(.top, 36)
                    .padding(.bottom, 18)
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
