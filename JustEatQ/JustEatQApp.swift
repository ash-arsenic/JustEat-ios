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
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
