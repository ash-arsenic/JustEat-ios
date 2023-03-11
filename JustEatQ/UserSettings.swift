//
//  UserSettings.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 27/02/23.
//

import Foundation

class UserSettings: ObservableObject {
    @Published var loggedIn = false
    
    func signIn() {
        loggedIn = true
    }
    
    func signOut() {
        loggedIn = false
    }
}
