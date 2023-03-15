//
//  UserData.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 14/03/23.
//

import Foundation

class UserData: ObservableObject {
    @Published var user: User
    
    init(_ user: User) {
        self.user = user
    }
    
}
