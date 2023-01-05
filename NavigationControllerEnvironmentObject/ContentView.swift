//
//  ContentView.swift
//  NavigationControllerEnvironmentObject
//
//  Created by Maris Lagzdins on 05/01/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var profile: Profile

    var body: some View {
        VStack {
            Text("Hello, \(profile.username)!")
        }
        .toolbar {
            ToolbarItem {
                NavigationLink("Settings") {
                    SettingsView()
                }
            }
        }
        .navigationTitle("Home")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Profile())
    }
}
