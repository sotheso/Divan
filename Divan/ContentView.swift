//
//  ContentView.swift
//  Divan
//
//  Created by Sothesom on 21/12/1403.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SearchView()
                .tabItem{
                    Label("جستجو", systemImage: "sparkles")
                }
            
            FalHafezView()
                .tabItem{
                    Label("فال", systemImage: "sparkles")
                }
        }
    }
}

#Preview {
    ContentView()
}
