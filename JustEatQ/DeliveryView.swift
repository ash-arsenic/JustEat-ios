//
//  DeliveryView.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 21/02/23.
//

import SwiftUI

struct DeliveryView: View {
    @ObservedObject var apiData: ApiData
    
    @State private var searchQuery = ""
    @State private var showConfirmationDialog = false
    
    @State private var showSortDialog = false
    @State private var sortDialogValue = 0
    
    @State private var showFilterDialog = false
    @State private var vegSelected = false
    @State private var minCostValue = ""
    @State private var maxCostValue = ""
    @State private var selectedCategories = [false, false, false, false, false, false]
    
    @State private var showRestrauntDishes = false

    @State var restraunts: [Restraunt]
    
    var body: some View {
        VStack {
            HStack { // Search Bar
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .foregroundColor(Color("PrimaryColor"))
                TextField("Restraunt name or text", text: $searchQuery)
                    .padding(.trailing, 24)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .foregroundColor(Color("PrimaryColor"))
                    .onChange(of: searchQuery, perform: { val in
                        restraunts = searchRestraunt(query: val, data: apiData.restraunts)
                    })
                Text("│").foregroundColor(Color.gray).font(.title2)
                Button(action: {
                    
                }, label: {
                    Image(systemName: "mic")
                    .font(.title3)
                    .foregroundColor(Color("PrimaryColor"))
                })
            }.padding(10)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color("LightGray"), radius: 8)
                .padding(.horizontal).padding(.top).padding(.bottom, 4)
            HStack {
                Button(action: {
                    showSortDialog = true
                }, label: {
                    HStack {
                        Image(systemName: "slider.horizontal.3").font(.subheadline)
                        Text("Sort").font(.subheadline)
                        Text("▼").font(.caption)
                    }.foregroundColor(Color("PrimaryColor"))
                }).padding(4)
                    .background(Color.white)
                    .cornerRadius(4)
                    .shadow(color: Color("LightGray"), radius: 8)
                Button(action: {
                    showFilterDialog = true
                }, label: {
                    HStack {
                        Image(systemName: "loupe").font(.subheadline)
                        Text("Filter").font(.subheadline)
                    }.foregroundColor(Color("PrimaryColor"))
                }).padding(4)
                    .background(Color.white)
                    .cornerRadius(4)
                    .shadow(color: Color("LightGray"), radius: 8)
            }.onAppear() {
                
            }
            List {
                ForEach(restraunts, id: \.id) { restraunt in
                    ZStack {
                        NavigationLink(destination: RestrauntItems(restraunt: restraunt, foods: apiData.foods)) {
                            EmptyView()
                        }.opacity(0.0).buttonStyle(PlainButtonStyle())
                        DeliveryRow(restraunt: restraunt, primaryFood: apiData.foods[restraunt.id! % 20])
                    }
                }.listRowSeparator(.hidden)
            }.listStyle(.plain)
        }.padding(.bottom, 4)
            .sheet(isPresented: $showSortDialog) {
                SortDialog(sortTypeSeleceted: $sortDialogValue, isPresented: $showSortDialog, action: {
                    showSortDialog = false
                    restraunts = sortRestraunts(sortType: sortDialogValue, data: restraunts)
                    print("Sort: \(restraunts.count)")
                }).presentationDetents([.height(UIScreen.main.bounds.height * 0.45)])
                    .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $showFilterDialog) {
                FilterDialog(showConfirmationDialog: $showFilterDialog, isVeg: $vegSelected, minValue: $minCostValue, maxValue: $maxCostValue, selectedCategories: $selectedCategories, action: {
                    showFilterDialog = false
                    restraunts = searchRestraunt(query: searchQuery, data: apiData.restraunts)
                    print("Filter: \(restraunts.count)")
                }).presentationDetents([.height(UIScreen.main.bounds.height * 0.62)])
                .presentationDragIndicator(.visible)
            }
    }
    
    func searchRestraunt(query: String, data: [Restraunt]) -> [Restraunt] {
        if query.count == 0 {
            return filterRestraunts(data: data)
        }
        let result = data.filter { restraunt in
            return restraunt.name!.lowercased().contains(query)
        }
        return filterRestraunts(data: result)
    }
    
    func filterRestraunts(data: [Restraunt]) -> [Restraunt] {
        var values: [Restraunt] = []
        var categoryIsSelected = false
        for i in 0..<selectedCategories.count {
            if selectedCategories[i] {
                categoryIsSelected = true
                let result = data.filter { restraunt in
                    return restraunt.category == "\(i+1)"
                }
                values += result
            }
        }
        if !categoryIsSelected {
            values = data
        }
        if vegSelected {
            let result = values.filter { restraunt in
                return restraunt.isVeg!
            }
            values = result
        }
        if minCostValue != "" {
            let result = values.filter { restraunt in
                return Int(restraunt.price!)! >= Int(minCostValue) ?? 0
            }
            values = result
        }
        if maxCostValue != "" {
            let result = values.filter { restraunt in
                return Int(restraunt.price!)! <= Int(maxCostValue) ?? 1000
            }
            values = result
        }
        return sortDialogValue != 0 ? sortRestraunts(sortType: sortDialogValue, data: values) : values
    }

    func sortRestraunts(sortType: Int, data: [Restraunt]) -> [Restraunt] {
        switch sortType {
        case 1:
            return data.sorted(by: {$0.rating!.count > $1.rating!.count})
        case 2:
            return data.sorted(by: {Int($0.distance!)! < Int($1.distance!)!})
        case 3:
            return data.sorted(by: {Int($0.distance!)! < Int($1.distance!)!})
        case 4:
            return data.sorted(by: {Int($0.price!)! < Int($1.price!)!})
        case 5:
            return data.sorted(by: {Int($0.price!)! > Int($1.price!)!})
        default:
            return apiData.restraunts
        }
    }
}

struct DeliveryView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryView(apiData: ApiData(restraunts: [Restraunt(data: [
            "D": false,
            "F": "3",
            "G": "250",
            "H": true,
            "I": "Huntersville, North Carolina, United States",
            "id": 1,
            "col1": "2",
            "rating": "⭐️",
            "fullName": "Sagar Ratna",])],
            foods: [Food(data: [
                "D": "Shakes",
                "E": "150",
                "G": "https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fmilk-shake&psig=AOvVaw1O74IwZJMMMQ9jD_LOhePZ&ust=1678262309447000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCMip_7esyf0CFQAAAAAdAAAAABAZ",
                "id": 1,
                "col1": "⭐️⭐️⭐️⭐️⭐️",
                "col2": "sweet beverage made by blending milk, ice cream, and flavorings or sweeteners such as butterscotch, caramel sauce, chocolate syrup, fruit syrup, or whole fruit into a thick, sweet, cold mixture.",
                "col3": "250",
                "isUser": "true"])]
        ), restraunts: [Restraunt(data: [
            "D": false,
            "F": "3",
            "G": "250",
            "H": true,
            "I": "Huntersville, North Carolina, United States",
            "id": 1,
            "col1": "2",
            "rating": "⭐️",
            "fullName": "Sagar Ratna",])])
    }
}
