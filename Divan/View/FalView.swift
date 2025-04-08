//
//  FalView.swift
//  TestDiv
//
//  Created by Sothesom on 22/12/1403.
//

import SwiftUI
import SafariServices
import AVFoundation

struct FalHafezView: View {
    @StateObject private var viewModel = FalHafezViewModel()
    @State private var hasTakenFal = false
    @Environment(\.colorScheme) var colorScheme
    @State private var showSafari = false
    @State private var selectedURL: URL?
    @State private var isAnimating = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // پس‌زمینه گرادیانت
                LinearGradient(
                    colors: [
                        Color(.systemBackground),
                        Color(.secondarySystemBackground)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // کارت اصلی
                        if let poem = viewModel.selectedPoem {
                            VStack(spacing: 20) {
                                Text(poem.title)
                                    .font(.system(.title2, design: .serif))
                                    .fontWeight(.bold)
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
                                    .tint(.blue)
                                    
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
                                        .tint(.orange)
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
                                        .tint(.purple)
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
                                    .tint(.blue)
                                }
                            }
                            .padding(24)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(.systemBackground))
                                    .shadow(radius: 8, x: 0, y: 4)
                            )
                            .padding(.horizontal)
                        } else {
                            // حالت خالی
                            VStack(spacing: 24) {
                                Image(systemName: "book.circle.fill")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .foregroundStyle(.blue)
                                
                                Text("برای گرفتن فال، نیت کنید و دکمه فال را لمس کنید")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(.secondary)
                                
                                Spacer()
                                Spacer()

                                HStack{
                                    Button(action: {
                                        // فعال کردن انیمیشن قبل از دریافت فال
                                        isAnimating = true
                                        
                                        // پس از مدتی کوتاه، فال را دریافت کن
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
                                    .controlSize(.large)
                                    
                                    Button(action: { viewModel.switchPoet() }) {
                                        Label("تغییر شاعر",
                                              systemImage: "arrow.triangle.2.circlepath")
                                        .frame(maxWidth: .infinity)
                                    }
                                    .buttonStyle(.bordered)
                                    .controlSize(.large)
                                }
                            }
                            .padding(.top, 200)
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.vertical)
                }
                
                // کامپوننت انیمیشن ورق زدن
                PageTurnAnimation(isAnimating: $isAnimating)
            }
            .navigationTitle("فال \(viewModel.selectedPoet.rawValue)")
            .sheet(isPresented: $showSafari) {
                if let url = selectedURL {
                    SafariView(url: url)
                }
            }
        }
    }
}

#Preview {
    FalHafezView()
}
