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
    @State private var isAnimating = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Color Back")
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    if let poem = viewModel.selectedPoem {
                        DetailView(
                            poem: poem,
                            hidesFavoriteButton: false,
                            showBackButton: true,
                            onBackButtonPressed: {
                                withAnimation {
                                    viewModel.selectedPoem = nil
                                    hasTakenFal = false
                                }
                            },
                            disableTopPadding: false
                        )
                    } else {
                        emptyStateView
                            .padding(.vertical)
                    }
                }
                
                PageTurnAnimation(isAnimating: $isAnimating)
            }
        }
    }
    
    // MARK: - Subviews
    
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
}

#Preview {
    FalView()
}
