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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    // Create a shared instance of FavoriteManager
    @StateObject private var favoriteManager = FavoriteManager.shared
    @AppStorage("signIn") private var isSignIn: Bool = false
    @AppStorage("didCompleteIntro") private var didCompleteIntro: Bool = false
    
    
    var body: some Scene {
        WindowGroup {
            if !didCompleteIntro {
                IntroView1()
            } else if !isSignIn {
                LoginScreen()
            } else {
                ContentView()
                    .environmentObject(favoriteManager)
            }
        }
    }

    init() {
        #if DEBUG
        // Force onboarding on every run in Debug builds
        UserDefaults.standard.set(false, forKey: "didCompleteIntro")
        UserDefaults.standard.set(false, forKey: "signIn")
        #endif
    }
}
