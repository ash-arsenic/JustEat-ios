//
//  JENavidationBar.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 06/03/23.
//

import SwiftUI

struct JENavidationBar: View {
    var title = "Just Eat It"
    
    @State private var showProfilePage = false
    
    var body: some View {
        ZStack {
            Color.clear
                .background(.ultraThinMaterial)
            ZStack {
                HStack {
                    NavigationLink(destination: ProfileView(), isActive: $showProfilePage) {
                        Button(action: {
                            showProfilePage = true
                        }, label: {
                            Image(systemName: "person.fill")
                                .foregroundColor(Color("PrimaryColor"))
                                .font(.headline)
                        })
                    }.navigationBarBackButtonHidden(true)
                    
                    Spacer()
                
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "character.book.closed.fill")
                            .font(.headline)
                    })
                
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.headline)
                    })
                }
                HStack {
                    Text(title)
                        .font(.title3.weight(.semibold))
                        .foregroundColor(Color("PrimaryColor"))
                }
                .padding(.leading, 64).padding(.trailing, 64)
            }.padding()
        }.frame(height: 50)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct JENavidationBar_Previews: PreviewProvider {
    static var previews: some View {
        JENavidationBar()
    }
}
