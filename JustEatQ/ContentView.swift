//
//  ContentView.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 20/02/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        NavigationView {
            if settings.loggedIn || UserDefaults.standard.bool(forKey: "loggedIn"){
                MainView()
            } else {
                GetStartedView()
            }
        }.onAppear() {
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserSettings())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
