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
    
    private var userName = UserDefaults.standard.value(forKey: "userName") as? String
    private var userEmail = UserDefaults.standard.value(forKey: "userEmail") as? String
    
    var body: some View {
        NavigationView {
            if settings.loggedIn || UserDefaults.standard.bool(forKey: "loggedIn"){
                MainView(userName: userName ?? "Shanaya", userEmail: userEmail ?? "shanayasinha8577@gmail.com")
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
