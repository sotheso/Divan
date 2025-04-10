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
    
    let poets = ["حافظ", "سعدی", "بابا طاهر", "مولانا", "خیام", "فردوسی"]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("ظاهر برنامه").dynamicFont(baseSize: 14)) {
                    Toggle(isOn: $appSettings.isDarkMode) {
                        Label("حالت تاریک", systemImage: "moon.fill")
                            .dynamicFont(baseSize: 16)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Label("اندازه متن", systemImage: "textformat.size")
                            .dynamicFont(baseSize: 16)
                        
                        Slider(value: $appSettings.fontSize, in: 0.8...1.5) {
                            Text("اندازه متن")
                        }
                        .tint(.purple)
                        
                        HStack {
                            Text("A")
                                .font(.system(size: 12 * appSettings.fontSize))
                            Spacer()
                            Text("A")
                                .font(.system(size: 24 * appSettings.fontSize))
                        }
                        .foregroundColor(.gray)
                    }
                    .padding(.vertical, 4)
                    
                    Toggle(isOn: $appSettings.isBoldFont) {
                        Label("متن ضخیم", systemImage: "bold")
                            .dynamicFont(baseSize: 16)
                    }
                }
                
                Section(header: Text("شخصی‌سازی").dynamicFont(baseSize: 14)) {
                    NavigationLink(destination: FavoriteIdsView()) {
                        Label("غزل‌های مورد علاقه", systemImage: "heart.fill")
                            .dynamicFont(baseSize: 16)
                    }
                    
                    NavigationLink(destination: Text("لیست علاقه‌مندی‌های شما").dynamicFont()) {
                        Label("علاقه‌مندی‌ها", systemImage: "star.fill")
                            .dynamicFont(baseSize: 16)
                    }
                    
                    Picker(selection: $appSettings.favoritePoet) {
                        ForEach(poets, id: \.self) { poet in
                            Text(poet)
                                .dynamicFont(baseSize: 16)
                                .tag(poet)
                        }
                    } label: {
                        Label("شاعر مورد علاقه", systemImage: "star.fill")
                            .dynamicFont(baseSize: 16)
                    }
                }
                
                Section(header: Text("درباره برنامه").dynamicFont(baseSize: 14)) {
                    HStack {
                        Text("نسخه برنامه")
                            .dynamicFont(baseSize: 16)
                        Spacer()
                        Text("1.0.0")
                            .dynamicFont(baseSize: 16)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("تنظیمات")
        }
    }
}

#Preview {
    SettingView()
        .environmentObject(AppSettings())
}
