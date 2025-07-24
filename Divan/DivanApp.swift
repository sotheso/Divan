//
//  DivanApp.swift
//  Divan
//
//  Created by Sothesom on 21/12/1403.
//

import SwiftUI
import CoreData
import Firebase


// Make FavoriteManager available in the global scope
typealias SharedFavoriteManager = FavoriteManager

@main
struct DivanApp: App {
    // Create a shared instance of FavoriteManager
    @StateObject private var favoriteManager = FavoriteManager.shared
    @State private var isLoggedIn: Bool = false
    
    @StateObject var viewModel = AutreViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if !isLoggedIn {
                IntroView1(isLoggedIn: $isLoggedIn)
            } else {
                ContentView()
                    .environmentObject(favoriteManager)
                    .environmentObject(viewModel)
                
            }
        }
    }
}
