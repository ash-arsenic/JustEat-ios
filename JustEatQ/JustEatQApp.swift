//
//  JustEatQApp.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 20/02/23.
//

import SwiftUI

@main
struct JustEatQApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserSettings())
//            if UserDefaults.standard.value(forKey: "loggedIn") as? String == "yes" {
//                ProfileView(name: "Shanaya", email: "shanayasinha8577@gmail.com")
//                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
//            } else {
//                GetStartedView()
//                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
//            }
//            ProfileView(name: "Shanaya", email: "shanayasinha8577@gmail.com")
//            GetStartedView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
