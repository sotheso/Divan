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
    @EnvironmentObject var viewModel: AutreViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                // بکگراند اصلی
                Color("Color Back")
                    .ignoresSafeArea()
                
                List {
                    if let user = viewModel.currentUser {
                        Section{
                            HStack{
                                Text(user.initials)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("Color Back"))
                                    .frame(width: 72, height: 72)
                                    .background(Color("Color").opacity(0.8))
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading, spacing: 4){
                                    Text(user.fullname)
                                        .fontWeight(.semibold)
                                        .padding(.top, 4)
                                    
                                    Text(user.email)
                                        .font(.footnote)
                                    
                                }
                                .foregroundColor(Color("Color").opacity(0.7))
                            }
                        }
                    }
                    else {
                        Text("وارد حساب کاربری بشید")
                    }
                    
                    
                    Section(header: Text("تنظیمات اپ")) {
                        Toggle(isOn: $appSettings.isDarkMode) {
                            Label("حالت شب", systemImage: "moon.fill")
                                .foregroundStyle(Color("Color"))
                        }
                    }
                    .listRowBackground(Color("Color Back"))
                    
                    Section(header: Text("ذخیره‌ها")) {
                        
                        NavigationLink{
                            MyFavoritePoemsView()
                        } label: {
                            SettingsRowView(imagName: "bookmark.fill", title: "شعرهای ذخیره شده", tintColor: Color("Color"))
                        }
                        
                        NavigationLink{
                            FavoritePoetsView(poets: Poet.samplePoets)
                        } label: {
                            SettingsRowView(imagName: "heart.fill", title: "شاعرهای مورد علاقه", tintColor: Color("Color"))
                        }
                    }
                    .listRowBackground(Color("Color Back"))
                    
                    Section("تماس با ما") {
                        NavigationLink{
                            AboutUsView()
                        } label: {
                            SettingsRowView(imagName: "info.circle.fill", title: "درباره ما", tintColor: Color("Color"))
                        }
                        
                        Link(destination: URL(string: "https://apps.apple.com/app/idXXXXXXXXXX?action=write-review")!) {
                            Label("امتیاز دادن به اپ", systemImage: "star.fill")
                                .foregroundStyle(Color("Color"))
                        }
                        
                        //                        Button{
                        //                            Link(destination: URL(string: "https://apps.apple.com/app/idXXXXXXXXXX?action=write-review")!)
                        //                        } label: {
                        //                            SettingsRowView(imagName: "star.fill", title: "امتیاز دادن به اپ", tintColor: Color("Color"))
                        //                        }
                    }
                    .listRowBackground(Color("Color Back"))
                    
                    Section("حساب کاربری") {
                        Button{
                            print("sign out ...")
                        } label: {
                            SettingsRowView(imagName: "multiply.circle.fill", title: "خروج از حساب کاربری", tintColor: .red)
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
        .environmentObject(AutreViewModel())
}
