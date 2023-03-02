//
//  UIComponents.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 21/02/23.
//

import SwiftUI

struct GroceryList: View {
    let imageName: String
    let line1: String
    let line2: String
    
    init(_ imageName: String, _ line1: String, _ line2: String) {
        self.imageName = imageName
        self.line1 = line1
        self.line2 = line2
    }
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .background(Color.yellow)
                .scaledToFit()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .frame(width: 50, height: 50)
            VStack {
                HStack {
                    Text(line1)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(alignment: .leading)
                    Spacer()
                }
                HStack {
                    Text(line2)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(alignment: .leading)
                    Spacer()
                }
            }.padding(.leading, 16)
        }.padding()
        .overlay {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color("LightGray"), lineWidth: 1)
        }
    }
}

struct CartItemsRows: View {
    var item: CartItem
    @State var cartItemCount: Int = 1
    
    init(_ item: CartItem, cartItemCount: Int) {
        self.item = item
        self.cartItemCount = cartItemCount
    }
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Image(systemName: "dot.square")
                        .foregroundColor(item.veg ? Color.green : Color.red)
                    Text(item.name)
                        .fontWeight(.semibold)
                        .font(.subheadline)
                    Spacer()
                }
                HStack {
                    Text("₹" + String(item.price))
                        .fontWeight(.semibold)
                        .font(.subheadline)
                    Spacer()
                }.padding(.leading, 25)
                Text(item.quantity)
                    .padding(.leading, 25)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.gray)
                    .font(.caption)
            }.padding(.trailing, 16)
            VStack { // Custom stepper
                HStack {
                    Button("-") {
                        if cartItemCount > 0 {
                            cartItemCount -= 1
                        }
                    }.tint(Color("PrimaryColor"))
                    Text(String(cartItemCount))
                        .padding(.horizontal, 4)
                    Button("+") {
                        cartItemCount += 1
                    }.tint(Color("PrimaryColor"))
                }.padding(.horizontal, 16).padding(.vertical, 2)
                    .background(Color("SecondaryColor"))
                    .cornerRadius(5)
                    .overlay (
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(Color("PrimaryColor"), lineWidth: 2)
                    )
            }
        }
        .padding()
    }
}

struct SectionHeader: View {
    var heading: String
    var width: CGFloat?
    init(heading: String, width: CGFloat?) {
        self.heading = heading
        self.width = width
    }
    var body: some View {
        HStack { // Section Heading
            VStack {
                Divider()
            }
            Text(heading)
                .kerning(2)
                .frame(width: (width ?? 150))
            VStack {
                Divider()
            }
        }.padding(.top, 32)
    }
}

struct DeliveryRow: View {
    var restraunt: Restraunt
    @State private var isFav = false
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("\(restraunt.dishes[restraunt.dishes.startIndex].name) ◦ ₹\(restraunt.dishes[restraunt.dishes.startIndex].price, specifier: "%.1f")")
                        .font(.caption.weight(.semibold))
                        .padding(.horizontal, 8).padding(.vertical, 4)
                        .background(Color.black.opacity(0.7))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 3))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                        isFav = !isFav
                    }, label: {
                        if isFav {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .font(.title2)
                        } else {
                            Image(systemName: "heart")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                    })
                }
                Spacer()
                HStack {
                    VStack {
                        HStack {
                            Text(restraunt.name).foregroundColor(.white)
                                .font(.title.weight(.heavy))
                            Spacer()
                        }
                        HStack {
                            Text(restraunt.category.joined(separator: " ◦ ")).foregroundColor(.white)
                                .font(.subheadline)
                            Spacer()
                        }
                    }
                    Spacer()
                    VStack {
                        Text("\(restraunt.ratings, specifier: "%.1f") ★")
                            .fontWeight(.bold)
                            .padding(8)
                            .background(Color(hue: 0.272, saturation: 0.927, brightness: 0.488))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                }
            }.padding()
            .frame(height: UIScreen.main.bounds.height * 0.25)
            .background(Image("SampleImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: UIScreen.main.bounds.height * 0.25)
                .clipped())
            HStack {
                Image(systemName: "stopwatch")
                Text("\(restraunt.getEstimatedTime()) ◦ \(restraunt.distance, specifier: "") km")
                Spacer()
                Text("₹\(restraunt.dishes[restraunt.dishes.startIndex].price, specifier: "%.1f") for one")
            }.padding()
                .font(.subheadline.weight(.medium))
        }.background(.white)
        .cornerRadius(20)
        .shadow(radius: 30)
    }
}

struct UIComponents_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryRow(restraunt: Restraunt(name: "Cake 'O' Clocks", category: ["Deserts", "Bakery"], ratings: 4.2, distance: 4, dishes: [Food(name: "Strawberry Cake", price: 130.0)]))
//        GroceryList("GroceryIcon1", "Enjoy 5000+ products to suit", "your needs")
//        CartItemsRows(CartItem(name: "Belgian Brownie Thick Shake", veg: false, price: 310.0, quantity: "[500 Ml]", counter: 1), cartItemCount: 1)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
