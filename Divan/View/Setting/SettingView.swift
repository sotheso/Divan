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
    @State private var appSettings = AppSettings()
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("ظاهر برنامه")) {
                    Toggle(isOn: $appSettings.isDarkMode) {
                        Label("حالت تاریک", systemImage: "moon.fill")
                    }
                }
                
                Section(header: Text("شخصی‌سازی")) {
                    NavigationLink(destination: MyFavoritePoemsView()) {
                        Label("غزل‌های مورد علاقه", systemImage: "heart.fill")
                    }
                }
                
                Section(header: Text("ارتباط با ما")) {
                    NavigationLink(destination: AboutUsView()) {
                        Label("درباره ما", systemImage: "info.circle.fill")
                    }
                    
                    Link(destination: URL(string: "https://apps.apple.com/app/idXXXXXXXXXX?action=write-review")!) {
                        Label("امتیاز دادن به ما", systemImage: "star.fill")
                    }
                }
            }
            .navigationTitle("تنظیمات")
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
                Link("Sothesom", destination: URL(string: "https://t.me/sothesom")!)
                    .foregroundColor(.blue)
                    .font(.footnote)
                
                Text("ساخته شده توسط ")
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
            Text("نسخه برنامه: 0.0.1")
                .foregroundColor(.gray)
                .font(.footnote)
        }
        .multilineTextAlignment(.center)
    }
}

#Preview {
    SettingView()
}
