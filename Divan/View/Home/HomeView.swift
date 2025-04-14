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
        VStack(alignment: .trailing) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(color.opacity(0.3), lineWidth: 1)
                )
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.background)
                .shadow(radius: 2, x: 0, y: 2)
        )
    }
}


