//
//  DivanApp.swift
//  Divan
//
//  Created by Sothesom on 21/12/1403.
//

import SwiftUI
import CoreData

// Make FavoriteManager available in the global scope
typealias SharedFavoriteManager = FavoriteManager

@main
struct DivanApp: App {
    // Create a shared instance of FavoriteManager
    @StateObject private var favoriteManager = FavoriteManager.shared
  
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favoriteManager)

        }
    }
}
