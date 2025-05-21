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
    @State private var isFavorite: Bool = false
    @State private var showFavoriteToast = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Color Back")
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        if let poem = viewModel.selectedPoem {
                            poemView(poem)
                        } else {
                            emptyStateView
                        }
                    }
                    .padding(.vertical)
                }
                
                PageTurnAnimation(isAnimating: $isAnimating)
            }
            .sheet(isPresented: $showSafari) {
                if let url = selectedURL {
                    safariOpen(url: url)
                }
            }
            .overlay(favoriteToastOverlay)
            .onAppear {
                if let _ = viewModel.selectedPoem {
                    isFavorite = checkIsFavorite()
                }
            }
            .onChange(of: viewModel.selectedPoem) { oldValue, newValue in
                if let _ = newValue {
                    isFavorite = checkIsFavorite()
                }
            }
        }
    }
    
    // MARK: - Subviews
    
    private func poemView(_ poem: Poem) -> some View {
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
            
            actionButtonsView(poem)
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("Color Back"))
                .shadow(color: Color("AccentColor").opacity(0.2), radius: 8, x: 0, y: 4)
        )
        .padding(.horizontal)
    }
    
    private func actionButtonsView(_ poem: Poem) -> some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                ShareLink(item: "\(poem.title)\n\n\(poem.content)\n\nوزن: \(poem.vazn ?? "")") {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
                .buttonStyle(.bordered)
                .tint(.blue)
                
                Button(action: {
                    savePoem()
                }) {
                    Label {
                        Text(isFavorite ? "Saved" : "Save")
                            .font(.callout)
                    } icon: {
                        Image(systemName: isFavorite ? "bookmark.fill" : "bookmark")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .tint(isFavorite ? .red : .pink)
            }
            
            podcastButtonsView(poem)
            
            Button(action: {
                withAnimation {
                    viewModel.selectedPoem = nil
                    hasTakenFal = false
                }
            }) {
                Label("Back", systemImage: "arrow.counterclockwise")
            }
            .buttonStyle(.bordered)
            .tint(Color("Color"))
        }
    }
    
    private func podcastButtonsView(_ poem: Poem) -> some View {
        VStack {
            if !poem.link1.isEmpty {
                HStack {
                    // خط سمت چپ
                    Rectangle()
                        .fill(Color("Color").opacity(0.4))
                        .frame(height: 1)
                    
                    // محتوای وسط
                    HStack(spacing: 4) {
                        Image(systemName: "info.circle")
                            .foregroundStyle(Color("Color"))
                        Text("Poetry details")
                            .font(.caption)
                            .foregroundStyle(Color("Color"))
                    }
                    
                    // خط سمت راست
                    Rectangle()
                        .fill(Color("Color").opacity(0.4))
                        .frame(height: 1)
                }
                .padding(.vertical, 8)
                Button(action: {
                    if let url = URL(string: poem.link1) {
                        selectedURL = url
                        showSafari = true
                    }
                }) {
                    Label {
                        Text("Ganjor")
                            .font(.callout)
                    } icon: {
                        Image("gan")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .tint(Color(red: 177/255, green: 72/255, blue: 51/255))
            }
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 24) {
            Image(systemName: "book.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundStyle(Color("Color"))
            
            Text("Focus your wish and press the Fortune button to receive your fortune.")
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color("Color"))
            
            Text("برای گرفتن فال، نیت کنید و دکمه فال را لمس کنید")
                .font(.body)
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
                    Label("فال " + viewModel.selectedCategory.displayName, systemImage: "sparkles")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color("Color"))
                .controlSize(.large)
                
                Picker(selection: $viewModel.selectedCategory, label: Label("انتخاب نوع شعر", systemImage: "arrow.triangle.2.circlepath").frame(maxWidth: .infinity)) {
                    ForEach(PoemCategory.allCases) { category in
                        Text(category.displayName).tag(category)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(maxWidth: .infinity)
                .background(Color("Color Back").opacity(0.8))
                .cornerRadius(8)
            }
        }
        .padding(.top, 200)
        .padding(.horizontal, 20)
    }
    
    private var favoriteToastOverlay: some View {
        Group {
            if showFavoriteToast {
                VStack {
                    Spacer()
                    
                    Text(isFavorite ? "Added to favorites" : "Removed from favorites")
                        .font(.footnote)
                        .padding()
                        .background(.regularMaterial)
                        .cornerRadius(10)
                        .padding(.bottom, 20)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                .animation(.easeInOut(duration: 0.3), value: showFavoriteToast)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        showFavoriteToast = false
                    }
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func addToFavorites() {
        guard let poem = viewModel.selectedPoem else { return }
        MyPoemSaver.shared.savePoem(
            id: poem.id.uuidString,
            title: poem.title,
            content: poem.content,
            poet: poem.poet.rawValue,
            vazn: poem.vazn,
            link1: poem.link1,
            link2: poem.link2
        )
    }
    
    private func removeFromFavorites() {
        guard let poem = viewModel.selectedPoem else { return }
        MyPoemSaver.shared.removePoem(id: poem.id.uuidString)
    }
    
    private func checkIsFavorite() -> Bool {
        guard let poem = viewModel.selectedPoem else { return false }
        return MyPoemSaver.shared.isPoemSaved(id: poem.id.uuidString)
    }
    
    private func savePoem() {
        if isFavorite {
            removeFromFavorites()
            isFavorite = false
        } else {
            addToFavorites()
            isFavorite = true
        }
        
        withAnimation {
            showFavoriteToast = true
        }
    }
}

#Preview {
    FalView()
}
