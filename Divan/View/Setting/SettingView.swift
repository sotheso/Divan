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
            .tint(Color("Color"))
            .overlay(
                VStack {
                    Spacer()
                    
                    // Apple Podcast Banner
                    Link(destination: URL(string: "https://podcasts.apple.com/us/podcast/الا-یا-ایها-الساقی-۰۱/id1459918086?i=1000650652264")!) {
                        HStack {
                            Image("Ravagh")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                            
                            Spacer()
                            
                            Text("گوش دادن حافظ در صدای سخن عشق")
                                .foregroundColor(.white)
                                .font(.headline)
                            
                            Spacer()
                            
                            Image("Podcasts")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color(red: 170/255, green: 197/255, blue: 216/255), Color(red: 183/255, green: 75/255, blue: 222/255)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)

                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    
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
