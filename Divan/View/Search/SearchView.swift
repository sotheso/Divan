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
    
    var body: some View {
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
            .background(.background)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color("Color").opacity(0.2), lineWidth: 1)
            )
            .shadow(color: Color("AccentColor").opacity(0.1), radius: 2, x: 0, y: 1)
            
            // دکمه تغییر شاعر
            poetSwitchButton
                .padding(.horizontal)
                .padding(.bottom)
            
            // نتایج جستجو
            if poemModel.searchResults.isEmpty {
                emptyStateView
            } else {
                searchResultsList
            }
        }
        .navigationTitle("جستجو در اشعار")
    }
    
    private var poetSwitchButton: some View {
        Button(action: { poemModel.switchPoet() }) {
            HStack {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .imageScale(.medium)
                Text("تغییر به \(poemModel.selectedPoet == .hafez ? "باباطاهر" : "حافظ")")
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .foregroundStyle(.white)
            .background(Color("Color").gradient)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
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
        .background(Color("Color").opacity(0.05))
    }
    
    private func poemCard(_ poem: Poem) -> some View {
        NavigationLink(destination: DetailView(poem: poem)) {
            VStack(alignment: .center, spacing: 12) {
                Text(poem.title)
                    .font(.headline)
                    .foregroundStyle(Color("Color"))
                    .lineLimit(1)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                
                Text(poem.content)
                    .font(.body)
                    .lineLimit(3)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }
            .frame(height: 120)
            .padding()
            .background(.background)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color("AccentColor").opacity(0.1), radius: 3, x: 0, y: 2)
        }
        .buttonStyle(.plain)
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "text.magnifyingglass")
                .font(.system(size: 48))
                .foregroundStyle(Color("Color"))
            
            Text("جستجو در اشعار \(poemModel.selectedPoet.rawValue)")
                .font(.headline)
                .foregroundStyle(Color("Color"))
            
            Text("برای یافتن اشعار مورد نظر خود، متنی را در کادر بالا وارد کنید")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Color").opacity(0.05))
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
}
