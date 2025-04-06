//
//  ContentView.swift
//  TestDiv
//
//  Created by Sothesom on 22/12/1403.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var settings: AppSettings
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Logo and Title Section
                HStack(spacing: 10) {
                    Image(systemName: "book.circle.fill")
                        .resizable()
                        .frame(width: 36, height: 36)
                        .foregroundColor(.purple)
                    
                    Spacer()
                    
                    Text("گنجینه‌ای از اشعار شاعران پارسی")
                        .dynamicFont(baseSize: 14)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 10)
                
                // Hafez Banner
                NavigationLink(destination: PoemD()) {
                    PoetBannerView(
                        title: "حافظ",
                        imageName: "Hafez",
                        color: .red
                    )
                }
                
                .padding()
                
                // Saadi Banner
                NavigationLink(destination: PoemD()) {
                    PoetBannerView(
                        title: "سعدی",
                        imageName: "Saadi",
                        color: .green
                    )
                }
                .padding()
                
                // Baba Taher Banner
                NavigationLink(destination: PoemD()) {
                    PoetBannerView(
                        title: "باباطاهر",
                        imageName: "BabaTaher",
                        color: .blue
                    )
                }
                .padding()
                
                // Molana Banner
                NavigationLink(destination: PoemD()) {
                    PoetBannerView(
                        title: "مولانا",
                        imageName: "Molana",
                        color: .purple
                    )
                }
                .padding()
                
            }
            .padding()
        }
        .navigationTitle("خانه")
    }
}

struct PoetBannerView: View {
    let title: String
    let imageName: String
    let color: Color
    
    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 20)
                .fill(color.opacity(0.1))
                .frame(height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(color.opacity(0.3), lineWidth: 1)
                )
            
            HStack(spacing: 15) {
                // Arrow Icon
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(color)
                    .padding(.trailing, 10)
                
                Spacer()
                Spacer()
                Spacer()

                
                VStack(alignment: .trailing, spacing: 5) {
                    Text(title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text("اشعار و غزلیات")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                Spacer()
                
                // Poet Image
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(color.opacity(0.5), lineWidth: 1)
                    )
                            
            }
            .padding(.horizontal, 15)
        }
    }
}

struct ContentView: View {
    @StateObject private var settings = AppSettings()
    
    var body: some View {
        NavigationView {
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
