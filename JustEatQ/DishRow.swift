//
//  DishRow.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 05/03/23.
//

import SwiftUI

struct DishRow: View {
    @State private var descriptionLineLimit = 3
    var food: Food
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Image(systemName: "dot.square").foregroundColor(food.isVeg! ? .green : .red)
                Text(food.name!).font(.title3.weight(.bold))
                HStack {
                    Text("\(food.rating!)")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .padding(6)
                        .background(Color(hue: 0.272, saturation: 0.927, brightness: 0.488))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    Text("\(food.totalVotes!) ratings")
                        .font(.footnote.weight(.semibold))
                }
                Text("₹\(food.price!)").font(.subheadline.weight(.bold))
                Text(food.description!).font(.caption).foregroundColor(.black.opacity(0.8))
                    .lineLimit(descriptionLineLimit)
                    .onTapGesture {
                        descriptionLineLimit = descriptionLineLimit == 3 ? 7 : 3
                    }
            }
            Spacer()
            VStack {
                AsyncImage(url: URL(string: food.image!)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.width * 0.45)
                .cornerRadius(20)
                .clipped()
                Button(action: {

                }, label: {
                    ZStack {
                        Text("ADD").foregroundColor(Color("PrimaryColor"))
                            .font(.headline.weight(.heavy))
                            .padding(.horizontal, 24).padding(8)
                        HStack {
                            Spacer()
                            VStack {
                                Image(systemName: "plus")
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color("PrimaryColor"))
                                Spacer()
                            }
                        }
                    }.padding(4)
                    .fixedSize(horizontal: true, vertical: true)
                    .background(Color("SecondaryColor"))
                    .cornerRadius(15)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("PrimaryColor"), lineWidth: 2))
                    .padding(.top, -36)
                })
            }
        }.padding(.vertical)
    }
}

struct DishRow_Previews: PreviewProvider {
    static var previews: some View {
        DishRow(food: Food(data: [
            "D": "Shakes",
                "E": "150",
                "G": "https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fmilk-shake&psig=AOvVaw1O74IwZJMMMQ9jD_LOhePZ&ust=1678262309447000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCMip_7esyf0CFQAAAAAdAAAAABAZ",
                "id": 1,
                "col1": "⭐️⭐️⭐️⭐️⭐️",
                "col2": "sweet beverage made by blending milk, ice cream, and flavorings or sweeteners such as butterscotch, caramel sauce, chocolate syrup, fruit syrup, or whole fruit into a thick, sweet, cold mixture.",
                "col3": "250",
                "isUser": "true"
        ]))
    }
}
