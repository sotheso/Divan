//
//  FalView.swift
//  TestDiv
//
//  Created by Sothesom on 22/12/1403.
//

import SwiftUI
import SafariServices
import AVFoundation

struct FalView: View {
    @StateObject private var viewModel = FalHafezViewModel()
    @State private var hasTakenFal = false
    @Environment(\.colorScheme) var colorScheme
    @State private var showSafari = false
    @State private var selectedURL: URL?
    @State private var isAnimating = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // حذف گرادینت و استفاده از رنگ یکدست
                Color("Color Back")
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // کارت اصلی
                        if let poem = viewModel.selectedPoem {
                            VStack(spacing: 20) {
                                Text(poem.title)
                                    .font(.system(.title2, design: .serif))
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color("Color"))
                                    .multilineTextAlignment(.center)
                                    .padding(.top)
                                
                                Text(poem.content)
                                    .font(.system(.body, design: .serif))
                                    .multilineTextAlignment(.center)
                                    .lineSpacing(8)
                                
                                if let vazn = poem.vazn {
                                    Text(vazn)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                
                                // دکمه‌های عملیات
                                VStack(spacing: 16) {
                                    ShareLink(item: "\(poem.title)\n\n\(poem.content)\n\nوزن: \(poem.vazn ?? "")") {
                                        Label("اشتراک‌گذاری", systemImage: "square.and.arrow.up")
                                    }
                                    .buttonStyle(.bordered)
                                    .tint(Color("Color"))
                                    
                                    // دکمه‌های پادکست
                                    if !poem.link1.isEmpty {
                                        Button(action: {
                                            if let url = URL(string: poem.link1) {
                                                selectedURL = url
                                                showSafari = true
                                            }
                                        }) {
                                            Label("گوش دادن در Castbox", systemImage: "headphones")
                                                .frame(maxWidth: .infinity)
                                        }
                                        .buttonStyle(.bordered)
                                        .tint(Color("Color"))
                                    }
                                    
                                    if !poem.link2.isEmpty {
                                        Button(action: {
                                            if let url = URL(string: poem.link2) {
                                                selectedURL = url
                                                showSafari = true
                                            }
                                        }) {
                                            Label("گوش دادن در Apple Podcast", systemImage: "headphones")
                                                .frame(maxWidth: .infinity)
                                        }
                                        .buttonStyle(.bordered)
                                        .tint(Color("Color"))
                                    }
                                    
                                    Button(action: {
                                        withAnimation {
                                            viewModel.selectedPoem = nil
                                            hasTakenFal = false
                                        }
                                    }) {
                                        Label("فال جدید", systemImage: "arrow.counterclockwise")
                                    }
                                    .buttonStyle(.bordered)
                                    .tint(Color("Color"))
                                }
                            }
                            .padding(24)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color("Color Back"))
                                    .shadow(color: Color("AccentColor").opacity(0.2), radius: 8, x: 0, y: 4)
                            )
                            .padding(.horizontal)
                        } else {
                            // حالت خالی
                            VStack(spacing: 24) {
                                Image(systemName: "book.circle.fill")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .foregroundStyle(Color("Color"))
                                
                                Text("برای گرفتن فال، نیت کنید و دکمه فال را لمس کنید")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(Color("Color"))
                                
                                Spacer()
                                Spacer()

                                HStack {
                                    Button(action: {
                                        isAnimating = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                            withAnimation {
                                                viewModel.getRandomPoem()
                                                hasTakenFal = true
                                            }
                                        }
                                    }) {
                                        Label("فال \(viewModel.selectedPoet.rawValue)", systemImage: "sparkles")
                                            .frame(maxWidth: .infinity)
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .tint(Color("Color"))
                                    .controlSize(.large)
                                    
                                    Button(action: { viewModel.switchPoet() }) {
                                        Label("تغییر شاعر",
                                              systemImage: "arrow.triangle.2.circlepath")
                                        .frame(maxWidth: .infinity)
                                    }
                                    .buttonStyle(.bordered)
                                    .tint(Color("Color"))
                                    .controlSize(.large)
                                }
                            }
                            .padding(.top, 200)
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.vertical)
                }
                
                PageTurnAnimation(isAnimating: $isAnimating)
            }
            .navigationTitle("فال \(viewModel.selectedPoet.rawValue)")
            .sheet(isPresented: $showSafari) {
                if let url = selectedURL {
                    safariOpen(url: url)
                }
            }
        }
    }
}

#Preview {
    FalView()
}
