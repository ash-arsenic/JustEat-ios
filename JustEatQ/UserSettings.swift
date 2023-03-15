//
//  UserSettings.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 27/02/23.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    @Published var loggedIn = false
    @Published var user = User()
    
    func signIn() {
        loggedIn = true
    }
    
    func signOut() {
        loggedIn = false
    }
    
    func setUser(user: User) {
        self.user = user
    }
    
    func setCartItems(items: [Cart]) {
        self.user.cartItem?.addingObjects(from: items)
    }
}
