//
//  ProfileView.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 26/02/23.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var userSettings: UserSettings
    
    @State private var showLoagoutDialog = false
    
    private var name = UserDefaults.standard.value(forKey: "userName") as? String ?? "Shanaya"
    private var email = UserDefaults.standard.value(forKey: "userEmail") as? String ?? "shanayasinha8077@gmail.com"
    
    var body: some View {
        VStack{
            HStack { // Header profile details
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.title)
                        .fontWeight(.semibold)
                    Text(email)
                        .lineLimit(0)
                        .tint(Color.black)
                    Button {
                        
                    } label: {
                        Text("View Activity ▶").foregroundColor(Color("PrimaryColor"))
                    }.padding(.vertical, 2)
                }
                VStack {
                    Image(systemName: (name[name.startIndex].lowercased() + ".circle.fill"))
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.green)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color("PrimaryColor"), lineWidth: 6))
                }.padding(.leading, 18)
            }.padding(.vertical, 24).padding(.horizontal, 12).padding(.trailing, 8)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 4)
            
            // End of Header profile details
            ScrollView {
                List {
                    Section(header: HStack {
                        Text("|").font(.largeTitle)
                            .fontWeight(.black).foregroundColor(Color("PrimaryColor"))
                        Text("Food Orders").foregroundColor(Color.black)
                        Spacer()
                    }) {
                        HStack {
                            Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                                .foregroundColor(Color("DarkGray"))
                                .padding(8)
                                .background(Color("SecondaryColor"))
                                .clipShape(Circle())
                            Text("Your orders")
                            Spacer()
                            Button {
                                
                            } label: {
                                Image(systemName: "chevron.right")
                            }
                        }
                        HStack {
                            Image(systemName: "a.book.closed.fill")
                                .foregroundColor(Color("DarkGray"))
                                .padding(8)
                                .background(Color("SecondaryColor"))
                                .clipShape(Circle())
                            Text("Address Book")
                            Spacer()
                            Button {
                                
                            } label: {
                                Image(systemName: "chevron.right")
                            }
                        }
                    }
                }.listStyle(InsetListStyle())
                    .cornerRadius(10)
                    .shadow(radius: 4)
                    .frame(height: 178)
                
                List {
                    Section(header: HStack {
                        Text("|").font(.largeTitle)
                            .fontWeight(.black).foregroundColor(Color("PrimaryColor"))
                        Text("More").foregroundColor(Color.black)
                        Spacer()
                    }) {
                        HStack {
                            Image(systemName: "info.circle")
                                .foregroundColor(Color("DarkGray"))
                                .padding(8)
                                .background(Color("SecondaryColor"))
                                .clipShape(Circle())
                            Text("About")
                            Spacer()
                            Button {
                                
                            } label: {
                                Image(systemName: "chevron.right")
                            }
                        }
                        HStack {
                            Image(systemName: "power")
                                .foregroundColor(Color("DarkGray"))
                                .padding(8)
                                .background(Color("SecondaryColor"))
                                .clipShape(Circle())
                            Text("Logout")
                            Spacer()
                            Button {
                                
                            } label: {
                                Image(systemName: "chevron.right")
                            }
                        }.contentShape(Rectangle()).onTapGesture(perform: {
                            showLoagoutDialog = true
                        })
                    }.alert("Are you sure you want to logout", isPresented: $showLoagoutDialog) {
                        Button("Logout") {
                            userSettings.signOut()
                            UserDefaults.standard.set(false, forKey: "loggedIn")
                        }
                        Button("Cancel", role: .cancel) {}
                    }
                }.listStyle(InsetListStyle())
                    .cornerRadius(10)
                    .shadow(radius: 4)
                    .frame(height: 160)
                Spacer()
            }
        }.padding(.horizontal, 8)
        .background(Color("SecondaryColor"))
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
