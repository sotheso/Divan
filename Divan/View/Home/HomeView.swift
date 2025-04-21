//
//  ContentView.swift
//  TestDiv
//
//  Created by Sothesom on 22/12/1403.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var settings: AppSettings
    @State private var showAlarmView = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Logo and Title Section
                HStack(spacing: 12) {
                    Button(action: {
                        showAlarmView = true
                    }) {
                        Image(systemName: settings.notificationsEnabled ? "bell.fill" : "bell")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.tint)
                            .symbolEffect(.bounce, value: settings.notificationsEnabled)
                    }
                    
                    Spacer()
                    
                    Text("Divan")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding(.vertical, 12)
                
                // Poets Grid
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 26) {
                    ForEach(Poet.samplePoets) { poet in
                        NavigationLink(destination: PoetProfileView(poet: poet)) {
                            PoetCardView(
                                title: poet.name,
                                subtitle: poet.works.first ?? "",
                                imageName: poet.imageName,
                                color: .purple
                            )
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("دیوان شعر پارسی")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showAlarmView) {
            AlarmView()
        }
    }
}

struct PoetCardView: View {
    let title: String
    let subtitle: String
    let imageName: String
    let color: Color
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // تصویر شاعر
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width / 2 - 30, height: UIScreen.main.bounds.width / 2 - 30)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            // گرادیانت برای خوانایی متن
            LinearGradient(
                gradient: Gradient(colors: [.black.opacity(0.7), .clear]),
                startPoint: .bottom,
                endPoint: .top
            )
            .frame(height: 45)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
            // نام شاعر
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.bottom, 8)
        }
        .frame(width: UIScreen.main.bounds.width / 2 - 30, height: UIScreen.main.bounds.width / 2 - 30)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.background)
        )
        .shadow(
            color: .black.opacity(0.3),    // سایه تیره‌تر
            radius: 8,                      // شعاع بزرگتر
            x: 0,
            y: 4                           // آفست عمودی بیشتر
        )
    }
}


