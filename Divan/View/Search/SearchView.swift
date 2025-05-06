//
//  HafezQListView.swift
//  Divan
//
//  Created by Sothesom on 21/12/1403.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var poemModel = PoemModel()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) private var dismiss
    var selectedCategory: PoemCategory?
    
    init(selectedCategory: PoemCategory? = nil) {
        self.selectedCategory = selectedCategory
    }
    
    var body: some View {
        ZStack {
            // بکگراند اصلی
            Color("Color Back")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // نوار جستجو
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color("Color"))
                    
                    TextField("جستجو در اشعار...", text: $poemModel.searchText)
                        .textFieldStyle(.plain)
                        .submitLabel(.search)
                    
                    if !poemModel.searchText.isEmpty {
                        Button(action: {
                            poemModel.searchText = ""
                            poemModel.search()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(Color("Color"))
                        }
                    }
                }
                .padding()
                .background(Color("Color Back"))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color("Color").opacity(0.2), lineWidth: 1)
                )
                .shadow(color: Color("AccentColor").opacity(0.3), radius: 4, x: 0, y: 2)
                .padding()
                
                // دکمه تغییر شاعر
                if selectedCategory == nil {
                    poetSwitchButton
                        .padding(.horizontal)
                        .padding(.bottom)
                }
                
                // نتایج جستجو
                if poemModel.searchResults.isEmpty {
                    emptyStateView
                } else {
                    searchResultsList
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(selectedCategory?.displayName ?? "جستجو در اشعار")
                    .font(.headline)
                    .foregroundStyle(Color("Color"))
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("بازگشت")
                    }
                }
            }
        }
        .onAppear {
            if let category = selectedCategory {
                poemModel.selectedCategory = category
                poemModel.loadPoems()
            }
        }
        .onChange(of: poemModel.selectedCategory) {
            poemModel.searchText = ""
            poemModel.loadPoems()
        }
        .onChange(of: poemModel.searchText) {
            poemModel.search()
        }
    }
    
    private var poetSwitchButton: some View {
        Picker(selection: $poemModel.selectedCategory, label:
            HStack {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .imageScale(.medium)
                Text("انتخاب نوع شعر")
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .foregroundStyle(.white)
            .background(Color("Color").gradient)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        ) {
            ForEach(PoemCategory.allCases) { category in
                Text(category.displayName).tag(category)
            }
        }
        .pickerStyle(MenuPickerStyle())
    }
    
    private var searchResultsList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(poemModel.searchResults) { poem in
                    poemCard(poem)
                        .onAppear {
                            if poem.id == poemModel.searchResults.last?.id {
                                poemModel.loadMoreContent()
                            }
                        }
                }
                
                if poemModel.isLoading {
                    ProgressView()
                        .tint(Color("Color"))
                        .frame(height: 50)
                }
            }
            .padding()
        }
        .background(Color("Color Back"))
    }
    
    private func poemCard(_ poem: Poem) -> some View {
        NavigationLink(destination: DetailView(poem: poem)) {
            VStack(alignment: .center, spacing: 12) {
                Text(poem.title)
                    .font(.headline)
                    .foregroundStyle(colorScheme == .dark ? .black : .white)
                    .lineLimit(1)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                
                Text(poem.content)
                    .font(.body)
                    .lineLimit(3)
                    .foregroundStyle(colorScheme == .dark ? .black.opacity(0.8) : .white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }
            .frame(height: 120)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(colorScheme == .dark ? .white : Color("Color"))
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "text.magnifyingglass")
                .font(.system(size: 48))
                .foregroundStyle(Color("Color"))
            
            Text("جستجو در اشعار " + (selectedCategory?.displayName ?? poemModel.selectedCategory.displayName))
                .font(.headline)
                .foregroundStyle(Color("Color"))
            
            Text("برای یافتن اشعار مورد نظر خود، متنی را در کادر بالا وارد کنید")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Color Back"))
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
}
