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
                            Label("خانه", systemImage: "house.fill")
                        }

                    SearchView()
                        .tabItem {
                            Label("جستجو", systemImage: "magnifyingglass")
                        }

                    FalHafezView()
                        .tabItem {
                            Label("فال", systemImage: "sparkles.square.filled.on.square")
                        }

                    SettingView()
                        .tabItem {
                            Label("تنظیمات", systemImage: "gearshape.fill")
                        }
                }
                .background(
                    Color.clear
                        .background(.ultraThinMaterial)
                        .edgesIgnoringSafeArea(.bottom)
                )
            }
        }
        .environmentObject(settings)
        .preferredColorScheme(settings.isDarkMode ? .dark : .light)
        .tint(Color.purple)
    }
}


#Preview {
    ContentView()
}
