//
//  ContentView.swift
//  TestDiv
//
//  Created by Sothesom on 25/01/1404.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var settings = AppSettings()
    @State private var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            LoginView()
        } else {
            IntroView0(isLoggedIn: $isLoggedIn)
        }
    }
}


#Preview {
    ContentView()
}
