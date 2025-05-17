//
//  SettingView.swift
//  TestDiv
//
//  Created by Sothesom on 04/01/1404.
//

import SwiftUI
import CoreData
import Foundation

struct SettingView: View {
    @EnvironmentObject var appSettings: AppSettings
    
    var body: some View {
        NavigationStack {
            ZStack {
                // بکگراند اصلی
                Color("Color Back")
                    .ignoresSafeArea()
                
                List {
                    Section(header: Text("App Appearance")) {
                        Toggle(isOn: $appSettings.isDarkMode) {
                            Label("Dark Mode", systemImage: "moon.fill")
                                .foregroundStyle(Color("Color"))
                        }
                    }
                    .listRowBackground(Color("Color Back"))
                    
                    Section(header: Text("Personalization")) {
                        NavigationLink(destination: MyFavoritePoemsView()) {
                            Label("Saved Poems", systemImage: "bookmark.fill")
                                .foregroundStyle(Color("Color"))
                        }
                        
                        NavigationLink(destination: FavoritePoetsView(poets: Poet.samplePoets)) {
                            Label("Favorite Poets", systemImage: "heart.fill")
                                .foregroundStyle(Color("Color"))
                        }
                    }
                    .listRowBackground(Color("Color Back"))
                    
                    Section(header: Text("About us")) {
                        NavigationLink(destination: AboutUsView()) {
                            Label("About us", systemImage: "info.circle.fill")
                                .foregroundStyle(Color("Color"))
                        }
                        
                        Link(destination: URL(string: "https://apps.apple.com/app/idXXXXXXXXXX?action=write-review")!) {
                            Label("Give Us a Rating", systemImage: "star.fill")
                                .foregroundStyle(Color("Color"))
                        }
                    }
                    .listRowBackground(Color("Color Back"))
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Setting")
            .tint(Color("Color"))
            .overlay(
                VStack {
                    Spacer()
                    FooterText()
                }
                .padding(.bottom, 20)
            )
        }
    }
}

struct FooterText: View {
    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 4) {
                Text("Developed by ")
                    .foregroundColor(.gray)
                    .font(.footnote)
                
                Link("Sothesom", destination: URL(string: "https://t.me/sothesom")!)
                    .foregroundColor(Color("Color"))
                    .font(.footnote)
            }
            Text("App Version: 0.0.1")
                .foregroundColor(.gray)
                .font(.footnote)
        }
        .multilineTextAlignment(.center)
    }
}

#Preview {
    SettingView()
        .environmentObject(AppSettings())
}
