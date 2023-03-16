//
//  DishRow.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 05/03/23.
//

import SwiftUI

struct DishRow: View {
    @EnvironmentObject var settings: UserSettings
    @State private var descriptionLineLimit = 3
    @State private var animateValue = 1.0
    @State private var disableButton = false
    @State private var showDSSAlert = false
    @Binding var showCartNotEmptyAlert: Bool
    @Binding var currentFoodItemId: String
    
    var distance: String
    var restrauntId: String
    var food: Food
    var itemQuanity: Int
    var incrementAction: (()->())
    var decrementAction: (()->())
    var addBtnAction: (()->())
    
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
                if itemQuanity == 0 {
                    Button(action: {

                    }, label: {
                        ZStack {
                            Text("ADD").foregroundColor(disableButton ? Color.gray : Color("PrimaryColor"))
                                .font(.headline.weight(.heavy))
                                .padding(.horizontal, 24).padding(8)
                            HStack {
                                Spacer()
                                VStack {
                                    Image(systemName: "plus")
                                        .fontWeight(.heavy)
                                        .foregroundColor(disableButton ? Color.gray : Color("PrimaryColor"))
                                    Spacer()
                                }
                            }
                        }.contentShape(Rectangle())
                        .onTapGesture {
                            currentFoodItemId = String(food.id!)
                            addBtnAction()
                        }
                        .padding(4)
                        .fixedSize(horizontal: true, vertical: true)
                        .background(disableButton ? Color("LightGray") : Color("SecondaryColor"))
                        .cornerRadius(15)
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(disableButton ? Color.gray : Color("PrimaryColor"), lineWidth: 2))
                        .padding(.top, -36)
                    }).buttonStyle(CustomButtonStyle())
                        .disabled(disableButton)
                } else {
                    HStack {
                        Button("-", action: decrementAction).tint(Color("PrimaryColor"))
                            .onTapGesture {
                                currentFoodItemId = String(food.id!)
                            decrementAction()
                        }
                        
                        Text(String(itemQuanity)).fontWeight(.bold)
                            .padding(.horizontal, 4)
                        Button("+", action: incrementAction).tint(Color("PrimaryColor"))
                            .onTapGesture {
                                currentFoodItemId = String(food.id!)
                            incrementAction()
                        }
                    }.font(.title).foregroundColor(Color("PrimaryColor"))
                    .padding(.horizontal, 16).padding(.vertical, 2)
                        .background(Color("SecondaryColor"))
                        .cornerRadius(5)
                        .overlay (
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .stroke(Color("PrimaryColor"), lineWidth: 2)
                        ).padding(.top, -24)
                }
                
            }
        }.padding(.vertical)
    }
    
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .scaleEffect(configuration.isPressed ? 1.5 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct DishRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack{}
//        DishRow(addedToCart: .constant(false), distance: "4", restrauntId: "22", food: Food(data: [
//            "D": "Shakes",
//            "E": "150",
//            "G": "https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fmilk-shake&psig=AOvVaw1O74IwZJMMMQ9jD_LOhePZ&ust=1678262309447000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCMip_7esyf0CFQAAAAAdAAAAABAZ",
//            "id": 1,
//            "col1": "⭐️⭐️⭐️⭐️⭐️",
//            "col2": "sweet beverage made by blending milk, ice cream, and flavorings or sweeteners such as butterscotch, caramel sauce, chocolate syrup, fruit syrup, or whole fruit into a thick, sweet, cold mixture.",
//            "col3": "250",
//            "isUser": "true"
//        ]))
    }
}
