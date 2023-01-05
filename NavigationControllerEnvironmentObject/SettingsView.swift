//
//  SettingsView.swift
//  NavigationControllerEnvironmentObject
//
//  Created by Maris Lagzdins on 05/01/2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var profile: Profile

    var body: some View {
        Form {
            Text("Username:")
            TextField("Provide your username", text: $profile.username)
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Profile())
    }
}
