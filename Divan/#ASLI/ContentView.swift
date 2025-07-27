//
//  ContentView.swift
//  TestDiv
//
//  Created by Sothesom on 25/01/1404.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var settings = AppSettings()

    var body: some View {
        NavigationStack {
            ZStack {
                TabView {
                    HomeView()
                        .tabItem {
                            Label("‌Home", systemImage: "house.fill")
                        }

                    SearchView()
                        .tabItem {
                            Label("Search", systemImage: "magnifyingglass")
                        }

                    FalView()
                        .tabItem {
                            Label("Fal", systemImage: "sparkles.square.filled.on.square")
                        }

                    SettingView()
                        .tabItem {
                            Label("Setting", systemImage: "gearshape.fill")
                        }
                }
                .ignoresSafeArea(.container, edges: [.leading, .trailing])
                .background(
                    Color.clear
                        .background(.ultraThinMaterial)
                        .edgesIgnoringSafeArea(.bottom)
                )
            }
        }
        .environmentObject(settings)
        .preferredColorScheme(settings.isDarkMode ? .dark : .light)
        .tint(Color("Color"))
    }
}


#Preview {
    ContentView()
}
