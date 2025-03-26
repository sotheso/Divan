//
//  SettingView.swift
//  TestDiv
//
//  Created by Sothesom on 04/01/1404.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var settings: AppSettings
    
    let poets = ["حافظ", "سعدی", "بابا طاهر", "مولانا", "خیام", "فردوسی"]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("ظاهر برنامه").dynamicFont(baseSize: 14)) {
                    Toggle(isOn: $settings.isDarkMode) {
                        Label("حالت تاریک", systemImage: "moon.fill")
                            .dynamicFont(baseSize: 16)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Label("اندازه متن", systemImage: "textformat.size")
                            .dynamicFont(baseSize: 16)
                        
                        Slider(value: $settings.fontSize, in: 0.8...1.5) {
                            Text("اندازه متن")
                        }
                        .tint(.purple)
                        
                        HStack {
                            Text("A")
                                .font(.system(size: 12 * settings.fontSize))
                            Spacer()
                            Text("A")
                                .font(.system(size: 24 * settings.fontSize))
                        }
                        .foregroundColor(.gray)
                    }
                    .padding(.vertical, 4)
                    
                    Toggle(isOn: $settings.isBoldFont) {
                        Label("متن ضخیم", systemImage: "bold")
                            .dynamicFont(baseSize: 16)
                    }
                }
                
                Section(header: Text("شخصی‌سازی").dynamicFont(baseSize: 14)) {
                    NavigationLink(destination: Text("لیست علاقه‌مندی‌های شما").dynamicFont()) {
                        Label("علاقه‌مندی‌ها", systemImage: "heart.fill")
                            .dynamicFont(baseSize: 16)
                    }
                    
                    Picker(selection: $settings.favoritePoet) {
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
