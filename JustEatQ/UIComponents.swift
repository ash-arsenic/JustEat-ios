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
                .padding(8)
                .background(Color.yellow.opacity(0.5))
                .scaledToFit()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .frame(width: 50, height: 50)
            VStack {
                HStack {
                    Text(line1)
                    Spacer()
                }
                HStack {
                    Text(line2)
                    Spacer()
                }
            }.padding(.leading, 16)
            .font(.callout)
            .fontWeight(.semibold)
            .frame(alignment: .leading)
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
            Text(heading).font(.callout)
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
    var primaryFood: Food
    
    @State private var isFav = false
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("\(primaryFood.name!) ◦ ₹\(primaryFood.price!)")
                        .font(.caption.weight(.semibold))
                        .padding(.horizontal, 8).padding(.vertical, 4)
                        .background(Color.black.opacity(0.7))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
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
                    }).onTapGesture {
                            isFav = !isFav
                    }
                }
                Spacer()
                HStack {
                    VStack {
                        HStack {
                            Text(restraunt.name!).foregroundColor(.white)
                                .font(.title.weight(.heavy))
                            
                            Image(systemName: "dot.square").foregroundColor(restraunt.isVeg! ? .green : .red)
                                .background(Color.gray)
                            Spacer()
                        }
                        HStack {
                            Text("\(getCategory(restraunt.category!))").foregroundColor(.white)
                                .font(.subheadline)
                            Spacer()
                        }
                    }
                    Spacer()
                    VStack {
                        Text("\(restraunt.rating!)")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(6)
                            .background(Color(hue: 0.272, saturation: 0.927, brightness: 0.488))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                }
            }.padding()
            .frame(height: UIScreen.main.bounds.height * 0.25)
            .background(AsyncImage(url: URL(string: primaryFood.image!)) { image in
                image.resizable()
            } placeholder: {
                Color("PrimaryColor")
            }
            .aspectRatio(contentMode: .fill)
            .frame(height: UIScreen.main.bounds.height * 0.25)
            .clipped())
            HStack {
                Image(systemName: "stopwatch")
                Text("\(getEstimatedTime(restraunt.distance!)) ◦ \(restraunt.distance!) km")
                Spacer()
                Text("₹\(restraunt.price!) for one")
            }.padding()
                .font(.subheadline.weight(.medium))
        }.background(.white)
        .cornerRadius(20)
        .shadow(radius: 8, x: 4, y: 4)
    }
    
    func getEstimatedTime(_ distance: String) -> String {
        let t = 10 + (Int(distance)! * 5)
        return "\(t) - \(t+5) min"
    }
    
    func getCategory(_ category: String) -> String {
        switch(category) {
        case "1":
            return "Starters"
        case "2":
            return "Deserts"
        case "3":
            return "Pizza & Burgers"
        case "4":
            return "South Indian"
        case "5":
            return "North Indian"
        case "6":
            return "Chinese"
        default:
            return "El Gurerro"
        }
    }
}

struct SortDialog: View {
    @Binding var sortTypeSeleceted: Int
    @Binding var isPresented: Bool
    var action: (()->())
    @State var relevanceSelected = [false, false, false, false, false]
    
    var body: some View {
        VStack {
            HStack {
                Text("Sort").font(.title2.weight(.semibold))
                Spacer()
            }.padding()
            Divider()
            VStack {
                HStack {
                    Text("Rating: High to Low")
                        .font(.headline.weight(.medium))
                    Spacer()
                    Circle()
                        .foregroundColor(relevanceSelected[0] ? Color("PrimaryColor") : Color.clear)
                        .frame(width: 10)
                        .padding(4)
                        .overlay(Circle().stroke(relevanceSelected[0] ? Color("PrimaryColor") : Color.gray, lineWidth: 2))
                }.contentShape(Rectangle())
                .padding(.horizontal, 16).padding(.vertical, 8)
                .onTapGesture {
                    updateRadioButtonState(selected: 0)
                }
                
                HStack {
                    Text("Delivery Time: Low to High")
                        .font(.headline.weight(.medium))
                    Spacer()
                    Circle()
                        .foregroundColor(relevanceSelected[1] ? Color("PrimaryColor") : Color.clear)
                        .frame(width: 10)
                        .padding(4)
                        .overlay(Circle().stroke(relevanceSelected[1] ? Color("PrimaryColor") : Color.gray, lineWidth: 2))
                }.contentShape(Rectangle())
                    .padding(.horizontal, 16).padding(.vertical, 8)
                    .onTapGesture {
                        updateRadioButtonState(selected: 1)
                    }
                
                HStack {
                    Text("Distance: Low to High")
                        .font(.headline.weight(.medium))
                    Spacer()
                    Circle()
                        .foregroundColor(relevanceSelected[2] ? Color("PrimaryColor") : Color.clear)
                        .frame(width: 10)
                        .padding(4)
                        .overlay(Circle().stroke(relevanceSelected[2] ? Color("PrimaryColor") : Color.gray, lineWidth: 2))
                }.contentShape(Rectangle())
                    .padding(.horizontal, 16).padding(.vertical, 8)
                    .onTapGesture {
                        updateRadioButtonState(selected: 2)
                    }
                
                HStack {
                    Text("Cost: Low To High")
                        .font(.headline.weight(.medium))
                    Spacer()
                    Circle()
                        .foregroundColor(relevanceSelected[3] ? Color("PrimaryColor") : Color.clear)
                        .frame(width: 10)
                        .padding(4)
                        .overlay(Circle().stroke(relevanceSelected[3] ? Color("PrimaryColor") : Color.gray, lineWidth: 2))
                }.contentShape(Rectangle())
                    .padding(.horizontal, 16).padding(.vertical, 8)
                    .onTapGesture {
                        updateRadioButtonState(selected: 3)
                    }
                
                HStack {
                    Text("Cost: High To Low")
                        .font(.headline.weight(.medium))
                    Spacer()
                    Circle()
                        .foregroundColor(relevanceSelected[4] ? Color("PrimaryColor") : Color.clear)
                        .frame(width: 10)
                        .padding(4)
                        .overlay(Circle().stroke(relevanceSelected[4] ? Color("PrimaryColor") : Color.gray, lineWidth: 2))
                }.contentShape(Rectangle())
                    .padding(.horizontal, 16).padding(.vertical, 8)
                    .onTapGesture {
                        updateRadioButtonState(selected: 4)
                    }
                
                Divider()
                
                HStack {
                    Button("Clear All") {
                        for i in 0..<relevanceSelected.count {
                            relevanceSelected[i] = false
                        }
                        sortTypeSeleceted = 0
                    }.padding(.horizontal, 24)
                    .foregroundColor(Color("PrimaryColor"))
                    
                    Button(action: action) {
                        Text("Apply")
                    }.frame(maxWidth: .infinity)
                        .padding()
                        .font(.title3.weight(.semibold))
                        .background(Color("PrimaryColor"))
                        .cornerRadius(15)
                        .foregroundColor(Color.white)
                }.padding(.horizontal).padding(.top)
            }.onAppear() {
                if sortTypeSeleceted != 0 {
                    relevanceSelected[sortTypeSeleceted-1] = true
                }
            }
        }
    }
    
    func updateRadioButtonState(selected: Int) {
        for i in 0..<relevanceSelected.count {
            if(i != selected) {
                relevanceSelected[i] = false
            }
        }
        relevanceSelected[selected] = true
        sortTypeSeleceted = selected + 1
    }
}

struct FilterDialog: View {
    @Binding var showConfirmationDialog: Bool
    
    @Binding var isVeg: Bool
    @Binding var minValue: String
    @Binding var maxValue: String
    @Binding var selectedCategories: [Bool]
    var action: (() -> Void)
    
    var body: some View {
            VStack {
                HStack {
                    Text("Filters").font(.title2.weight(.semibold))
                    Spacer()
                }.padding(.horizontal)
                Divider()
                
                HStack {
                    Toggle(isOn: $isVeg) {
                        Text("Veg Only")
                            .font(.callout.weight(.medium))
                    }.toggleStyle(SwitchToggleStyle(tint: Color("PrimaryColor")))
                }.padding(.horizontal)
                
                Divider()
                
                HStack {
                    VStack {
                        Text("Min")
                            .font(.callout.weight(.medium))
                        TextField("", text: $minValue)
                            .keyboardType(.decimalPad)
                            .padding(.horizontal, 16).padding(.vertical, 8)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2))
                            .frame(width: UIScreen.main.bounds.width * 0.15)
                    }.frame(maxWidth: .infinity)
                
                    Text("Price")
                        .font(.headline.weight(.semibold))
                
                    VStack {
                        Text("Max")
                            .font(.callout.weight(.medium))
                        TextField("", text: $maxValue)
                            .keyboardType(.decimalPad)
                            .padding(.horizontal, 16).padding(.vertical, 8)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2))
                            .frame(width: UIScreen.main.bounds.width * 0.15)
                    }.frame(maxWidth: .infinity)
                }.padding()
                
                Divider()
                
                VStack {
                    Text("Categories")
                        .font(.headline.weight(.semibold))
                    HStack {
                        Spacer()
                        Text("Starters")
                            .onTapGesture {
                                selectedCategories[0] = !selectedCategories[0]
                            }
                            .foregroundColor(selectedCategories[0] ? Color("PrimaryColor") : Color.gray)
                            .padding(12)
                            .font(.callout.weight(.medium))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(selectedCategories[0] ? Color("PrimaryColor") : Color.gray, lineWidth: 2))
                        Spacer()
                        Text("Desert")
                            .onTapGesture {
                                selectedCategories[1] = !selectedCategories[1]
                            }
                            .foregroundColor(selectedCategories[1] ? Color("PrimaryColor") : Color.gray)
                            .padding(12)
                            .font(.callout.weight(.medium))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(selectedCategories[1] ? Color("PrimaryColor") : Color.gray, lineWidth: 2))
                        Spacer()
                        Text("Pizza & Burgers")
                            .onTapGesture {
                                selectedCategories[2] = !selectedCategories[2]
                            }
                            .foregroundColor(selectedCategories[2] ? Color("PrimaryColor") : Color.gray)
                            .padding(12)
                            .font(.callout.weight(.medium))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(selectedCategories[2] ? Color("PrimaryColor") : Color.gray, lineWidth: 2))
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("South Indian")
                            .onTapGesture {
                                selectedCategories[3] = !selectedCategories[3]
                            }
                            .foregroundColor(selectedCategories[3] ? Color("PrimaryColor") : Color.gray)
                            .padding(12)
                            .font(.callout.weight(.medium))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(selectedCategories[3] ? Color("PrimaryColor") : Color.gray, lineWidth: 2))
                        Spacer()
                        Text("North Indian")
                            .onTapGesture {
                                selectedCategories[4] = !selectedCategories[4]
                            }
                            .foregroundColor(selectedCategories[4] ? Color("PrimaryColor") : Color.gray)
                            .padding(12)
                            .font(.callout.weight(.medium))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(selectedCategories[4] ? Color("PrimaryColor") : Color.gray, lineWidth: 2))
                    
                        Spacer()
                        Text("Chineese")
                            .onTapGesture {
                                selectedCategories[5] = !selectedCategories[5]
                            }
                            .foregroundColor(selectedCategories[5] ? Color("PrimaryColor") : Color.gray)
                            .padding(12)
                            .font(.callout.weight(.medium))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(selectedCategories[5] ? Color("PrimaryColor") : Color.gray, lineWidth: 2))
                        Spacer()
                    }
                }.padding()
                
                Divider()
                
                HStack {
                    Button("Clear All") {
                        for i in 0..<selectedCategories.count {
                            selectedCategories[i] = false
                        }
                        isVeg = false
                        minValue = ""
                        maxValue = ""
                    }.font(.title3.weight(.semibold))
                        .padding(.horizontal, 24).foregroundColor(Color("PrimaryColor"))
                    Button(action: action, label: {
                        Text("Apply")
                    }).frame(maxWidth: .infinity)
                        .padding()
                        .font(.title3.weight(.semibold))
                        .background(Color("PrimaryColor"))
                        .cornerRadius(15)
                        .foregroundColor(Color.white)
                    }.padding(.horizontal, 16)
            }
    }
}

struct UIComponents_Previews: PreviewProvider {
    static var previews: some View {
//        DeliveryRow(restraunt: Restraunt(data: [
//            "D": false,
//            "F": "3",
//            "G": "250",
//            "H": true,
//            "I": "Huntersville, North Carolina, United States",
//            "id": 1,
//            "col1": "2",
//            "rating": "⭐️",
//            "fullName": "Sagar Ratna"]))
        Color.red
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

struct StraightLine: Shape {
    func path(in rect: CGRect) -> Path {
        Path() { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}
