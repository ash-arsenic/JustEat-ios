//
//  CartView.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 21/02/23.
//

import SwiftUI

struct CartItem: Identifiable {
    let id = UUID()
    var name: String
    var veg: Bool
    var price: Double
    var quantity: String
    var counter : Int
    var totalPrice: Double
}

struct CartView: View {
    
    @EnvironmentObject var settings: UserSettings
    
    @State private var cartItems: [Cart] = []
    @State private var refreshId = UUID()
//  For going back to delivery page
    @Binding var tabSelected: Int
    
    //    For estimated time
    //    Sample Data for list
    @State private var items = [CartItem(name: "Belgian Brownie Thick Shake", veg: true, price: 310.0, quantity: "[500 Ml]", counter: 1, totalPrice: 310.0),
    CartItem(name: "Oreo Waffle", veg: false, price: 125.0, quantity: "Single, Hot Fudge", counter: 1, totalPrice: 125.0)]
    @State private var showRemoveAlert = false
    @State private var currentCartItemId: String?
    
//    For delivery distance
    @State private var deliveryDistance = 0
    
    //    For showing optional views
    @State private var cartIsEmpty = false
    @State private var showBillInfo = false
    
    //    For bill summary
    @State private var subTotalPrice = 230.45
    @State private var gstPrice = 32.78
    @State private var deliveryCharges = 75.30
    
    //    For bottom menu
    @State private var currentPaymentWay = "Wallet"
    @State private var currentPaymentImage = "menubar.dock.rectangle"
    
    //    For placeorder button
    @State private var totalAmount = 425.25
   
    init(selection: Binding<Int>) {
        self._tabSelected = selection
    }
    
    var body: some View {
        ZStack {
            Color("PrimaryColor")
                .edgesIgnoringSafeArea(.top)
            
            if cartItems.count == 0 {
                VStack {
                    Image("EmptyCart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    Text("Please add some item to cart")
                    
                }.onAppear() {
                    if let items = settings.user.cartItem?.allObjects as? [Cart] {
                        self.cartItems = items
                        deliveryDistance = getMaxDistance()
                    }
                }
            }
            else {
                VStack {
                    ScrollView { // For whole scrollable content
                        VStack { // Contains all the content under scroll view
                            HStack { // For showing the estimated delivery time
                                Image(systemName: "stopwatch")
                                    .foregroundColor(Color("PrimaryColor"))
                                Text("Delivery in").fontWeight(.medium)
                                Text(calculateTime())
                                    .fontWeight(.bold)
                                Spacer()
                            }.font(.subheadline)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            
                            Group {  // Items Added
                                SectionHeader(heading: "ITEM(S) ADDED", width: 150)
                                
                                VStack { // Cart items
                                    ForEach(cartItems, id: \.cartId) { item in
                                        HStack {
                                            VStack {
                                                HStack {
                                                    Image(systemName: "dot.square")
                                                        .foregroundColor(item.isVeg ? Color.green : Color.red)
                                                    Text(item.name ?? "pp")
                                                        .fontWeight(.semibold)
                                                        .font(.subheadline)
                                                    Spacer()
                                                }
                                                HStack {
                                                    Text("₹\(item.price ?? "0")")
                                                        .fontWeight(.semibold)
                                                        .font(.subheadline)
                                                    Spacer()
                                                }.padding(.leading, 25)
                                                
                                                Text("\(item.distance ?? "gh") km far away")
                                                    .padding(.leading, 25)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .foregroundColor(Color.gray)
                                                    .font(.caption)
                                            }.padding(.trailing, 16)
                                            VStack { // Custom stepper
                                                HStack {
                                                    Button("-") {
                                                        currentCartItemId = item.cartId
                                                        item.quantity == 1 ? showRemoveAlert = true : updateCartItems(id: item.cartId!, inc: false)
                                                    }.tint(Color("PrimaryColor"))
                                                    
                                                    Text(String(item.quantity))
                                                        .padding(.horizontal, 4)
                                                    Button("+") {
                                                        currentCartItemId = item.cartId
                                                        updateCartItems(id: item.cartId!, inc: true)
                                                    }.tint(Color("PrimaryColor"))
                                                        .alert(isPresented: $showRemoveAlert) {
                                                            Alert(
                                                                title: Text("Are you sure you want to remove this item from the caart"),
                                                                message: Text("There is no undo"),
                                                                primaryButton: .destructive(Text("Remove")) {
                                                                    deleteCartItem(id: currentCartItemId!)
                                                                },
                                                                secondaryButton: .cancel()
                                                            )
                                                        }
                                                    
                                                }.padding(.horizontal, 16).padding(.vertical, 2)
                                                    .background(Color("SecondaryColor"))
                                                    .cornerRadius(5)
                                                    .overlay (
                                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                                            .stroke(Color("PrimaryColor"), lineWidth: 2)
                                                    )
                                                Text("₹\(item.quantity * Int64(item.price ?? "0")!)")
                                                    .fontWeight(.semibold)
                                                    .font(.subheadline)
                                            }
                                        }.padding()
                                        Divider()
                                    }
                                }.id(settings.refreshId)
                                .background(Color.white)
                                .cornerRadius(15)
                                
                                VStack {
                                    HStack {
                                        Image(systemName: "plus.circle")
                                        Text("Add more items").font(.callout)
                                        Spacer()
                                        Button(action: {
                                            
                                        }, label: {
                                            Image(systemName: "chevron.forward")
                                                .foregroundColor(Color.gray)
                                        })
                                    }.onTapGesture(perform: {
                                        tabSelected = 0
                                    })
                                    VStack{
                                        Divider()
                                    }
                                    HStack {
                                        Image(systemName: "square.and.pencil")
                                        Text("Add cooking instructions").font(.callout)
                                        Spacer()
                                        Button(action: {
                                            
                                        }, label: {
                                            Image(systemName: "chevron.forward")
                                                .foregroundColor(Color.gray)
                                        })
                                    }
                                }.padding()
                                    .background(Color.white)
                                    .cornerRadius(15)
                            }
                            // NA
                            Group {
                                SectionHeader(heading: "BILL SUMMARY", width: 150)
                                VStack {
                                    HStack{
                                        Text("Subtotal")
                                        Spacer()
                                        Text("₹\(subTotalPrice, specifier: "%.2f")")
                                    }.fontWeight(.bold)
                                        .font(.system(size: 18))
                                        .padding(8)
                                    HStack{
                                        Image(systemName: "building.columns")
                                        Text("GST and restaurant charges")
                                        Spacer()
                                        Text("₹\(gstPrice, specifier: "%.2f")")
                                    }.font(.system(size: 15)).padding(4)
                                    HStack{
                                        Image(systemName: "scooter")
                                        Text("Delivery partner fee for \(deliveryDistance)km")
                                        Spacer()
                                        Text("₹\(deliveryCharges, specifier: "%.2f")")
                                    }.font(.system(size: 15)).padding(4)
                                    Text("fully goes to them for their time and effort")
                                        .fontWeight(.medium)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.system(size: 13))
                                        .foregroundColor(.gray).padding(.leading, 25)
                                    HStack{
                                        Button(action: {
                                            showBillInfo = !showBillInfo
                                        }, label: {
                                            Text("See how this is calculated").font(.callout)
                                            Image(systemName: "arrowtriangle.down.fill").resizable().frame(width: 8, height: 6)
                                        }).tint(Color("PrimaryColor")).frame(width: 230, height: 30).overlay {
                                            RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color("PrimaryColor"),lineWidth: 1)
                                        }.padding(.leading, 25).padding(.bottom,8)
                                        Spacer()
                                    }
                                    if showBillInfo {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text("Base fee upto 5 km")
                                                Spacer()
                                                Text("₹31")
                                            }.font(.callout)
                                            HStack {
                                                Text("Long distance fees")
                                                Spacer()
                                                Text("₹25")
                                            }.font(.callout)
                                            Text("Charged from 5 km ownwards")
                                                .foregroundColor(Color.gray)
                                                .font(.footnote)
                                        }.padding()
                                            .background(Color("LightGray"))
                                            .cornerRadius(15).padding(.leading, 20)
                                    }
                                    Divider()
                                    HStack{
                                        Text("Grand Total").frame(maxWidth: .infinity, alignment: .leading)
                                        Text("₹\(totalAmount, specifier: "%.2f")")
                                    }.fontWeight(.semibold)
                                }.padding(16).frame(maxWidth: .infinity).background(.white).cornerRadius(15)
                            }
                            // NA
                            
                            // Your details
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Your Details")
                                        .fontWeight(.semibold)
                                    Text("\(settings.user.name!), \(settings.user.email!)")
                                        .foregroundColor(Color.gray)
                                }
                                Spacer()
                                Button(action: {
                                    
                                }, label: {
                                    Image(systemName: "chevron.forward")
                                        .foregroundColor(Color.gray)
                                })
                            }.contentShape(Rectangle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            
                            // Order for someone else
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Order for someone else")
                                        .fontWeight(.semibold)
                                    Text("Send personalised message")
                                        .foregroundColor(Color.gray)
                                }
                                Spacer()
                                Button(action: {
                                    
                                }, label: {
                                    Image(systemName: "chevron.forward")
                                        .foregroundColor(Color.gray)
                                })
                            }.padding()
                                .background(Color.white)
                                .cornerRadius(15)
                            
                            // Cancellation Policy
                            
                            SectionHeader(heading: "CANCELLATION POLICY", width: 240)
                            HStack{
                                Text("100% cancellation fee will be applicable if you decide to cancel the order anytime after order placement. Avoid cancellation as it leads to food wastage")
                                    .foregroundColor(Color.gray)
                            }.padding()
                                .background(Color.white)
                                .cornerRadius(15)
                        }.padding()
                    }
                    
                    // Bottom Placement View
                    VStack { // Bottom Payment Option
                        VStack { // Location Change
                            HStack {
                                Image(systemName: "mappin")
                                    .foregroundColor(Color("PrimaryColor"))
                                Text("Delivery at")
                                    .font(.subheadline)
                                Text("Work")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Spacer()
                                Button("Change") {
                                    
                                }.foregroundColor(Color("PrimaryColor"))
                            }
                            Text("Rapipay, 8 Floor, QA Infotech, Block A, sector 68, Noida")
                                .font(.caption)
                                .foregroundColor(Color.gray)
                                .lineLimit(1)
                                .padding(.horizontal, 24)
                        }.padding(.horizontal, 24)
                        Divider()
                        VStack { // Place order button view
                            HStack {
                                VStack { // FOR Payusing and its label
                                    HStack {
                                        Image(systemName: currentPaymentImage)
                                            .font(.callout)
                                            .foregroundColor(Color.gray)
                                        Menu("PAY USING ▲") {
                                            Button("Wallet") {
                                                currentPaymentWay = "Wallet"
                                                currentPaymentImage = "menubar.dock.rectangle"
                                            }
                                            Button("COD") {
                                                currentPaymentWay = "COD"
                                                currentPaymentImage = "indianrupeesign.circle.fill"
                                            }
                                        }
                                        .foregroundColor(Color.gray)
                                        .font(.subheadline)
                                    }
                                    Text(currentPaymentWay)
                                        .font(.caption)
                                }
                                VStack { // FOR Paynow button
                                    Button(action: {
                                        
                                    }) {
                                        HStack{
                                            VStack{
                                                Text("₹\(totalAmount, specifier: "%.2f")")
                                                    .foregroundColor(Color.white)
                                                Text("TOTAL")
                                                    .foregroundColor(Color.white)
                                                    .font(.caption)
                                            }.padding(.leading, 12)
                                            Spacer()
                                            Text("Place Order ►")
                                                .foregroundColor(Color.white)
                                            Spacer()
                                        }
                                    }
                                    .padding(.vertical, 12)
                                    .background(Color("PrimaryColor"))
                                    .cornerRadius(8)
                                }
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 24)
                            Divider()
                        }.onAppear() {
                            updateBillinigDetails()
                        }
                    }
                    .padding(.top, 12)
                    .background(Color.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                }
            }
        }.onAppear() {
            if let items = settings.user.cartItem?.allObjects as? [Cart] {
                self.cartItems = items
                deliveryDistance = getMaxDistance()
            }
        }
    }
    
    func updateCartItems(id: String, inc: Bool) {
        var ind: Int = 0
        for i in 0..<cartItems.count {
            if cartItems[i].cartId == id {
                ind = i
                break
            }
        }
        
        if inc {
            cartItems[ind].quantity = cartItems[ind].quantity + 1
        } else {
            cartItems[ind].quantity = cartItems[ind].quantity - 1
        }
        settings.refreshCart()
//        for i in 0..<(settings.user.cartItem?.allObjects as! [Cart]).count {
//            if((settings.user.cartItem?.allObjects as! [Cart])[i].id == id) {
//                ind = i
//                break
//            }
//        }
//        if inc {
//            (settings.user.cartItem?.allObjects as! [Cart])[ind].quantity = String(Int((settings.user.cartItem?.allObjects as! [Cart])[ind].quantity!)! + 1)
//            cartItems[ind].quantity = String(Int(cartItems[ind].quantity!)! + 1)
//            print(ind, (settings.user.cartItem?.allObjects as! [Cart])[ind].quantity!)
//        } else {
//            (settings.user.cartItem?.allObjects as! [Cart])[ind].quantity = String(Int((settings.user.cartItem?.allObjects as! [Cart])[ind].quantity!)! - 1)
//            cartItems[ind].quantity = String(Int(cartItems[ind].quantity!)! - 1)
//            print(ind, (settings.user.cartItem?.allObjects as! [Cart])[ind].quantity!)
//        }
        print(ind, cartItems[ind].quantity)
        PersistenceController.shared.save()
        updateBillinigDetails()
    }
    
    func deleteCartItem(id: String) {
        var ind = -1
        for i in 0..<cartItems.count {
            if(cartItems[i].cartId == id) {
                ind = i
                break
            }
        }
        if ind != -1 {
            PersistenceController.shared.deleteCartItem(item: cartItems[ind])
            cartItems.remove(at: ind)
            settings.setCartItems(items: cartItems)
            PersistenceController.shared.save()
        } else {
            print("ID not found")
        }
        settings.refreshCart()
//
        updateBillinigDetails()
    }
    
    func getMaxDistance() -> Int{
        var dis = 0
        for i in cartItems {
            if dis < Int(i.distance!)! {
                dis = Int(i.distance!)!
            }
        }
        return dis
    }
    
    func updateBillinigDetails() {
        deliveryDistance = getMaxDistance()
        var newSubTotal = 0.0
        for item in cartItems {
            newSubTotal += Double(item.quantity * Int64(item.price!)!)
        }
        subTotalPrice = newSubTotal
        gstPrice = 0.18 * subTotalPrice
        deliveryCharges = calculateDeliveryPrice(distance: deliveryDistance)
        totalAmount = subTotalPrice + gstPrice + deliveryCharges
    }
    
    func calculateTime() -> String {
        let time = 10 + deliveryDistance * 4
        return "\(time)-\(time+5) min"
    }
    
    func calculateDeliveryPrice(distance: Int) -> Double {
        if distance <= 5 {
            return 31.0
        }
        return 31.0 + ((Double(distance) - 5) * 25.0)
    }
}
struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(selection: .constant(0))
    }
}
