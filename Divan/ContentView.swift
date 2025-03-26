//
//  ContentView.swift
//  Divan
//
//  Created by Sothesom on 21/12/1403.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var settings = AppSettings()

    var body: some View {
        NavigationView {
            TabView {
                SearchView()
                    .tabItem{
                        Label("جستجو", systemImage: "sparkles")
                    }
                
                FalHafezView()
                    .tabItem{
                        Label("فال", systemImage: "sparkles")
                    }
                SettingView()
                    .tabItem {
                        Label("تنظیمات", systemImage: "gear")
                    }
            }
        }
        .environmentObject(settings)
        .preferredColorScheme(settings.isDarkMode ? .dark : .light)
    }
}

#Preview {
    ContentView()
}
