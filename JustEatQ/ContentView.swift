//
//  ContentView.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 20/02/23.
//

import SwiftUI
import CoreData
import UIKit

struct ContentView: View {
    @EnvironmentObject var settings: UserSettings
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>
    
    init() {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "PrimaryColor")!]

            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "PrimaryColor")!]
        }
    
    var body: some View {
        NavigationView {
            if settings.loggedIn || UserDefaults.standard.bool(forKey: "loggedIn"){
                MainView().onAppear() {
                    for user in users {
                        if user.email == UserDefaults.standard.value(forKey: "userEmail") as? String {
                            settings.setUser(user: user)
                        }
                    }
                }
            } else {
                GetStartedView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserSettings())
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
