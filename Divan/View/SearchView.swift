//
//  HafezQListView.swift
//  Divan
//
//  Created by Sothesom on 21/12/1403.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    @State private var selectedPoet: String = ""
    @StateObject private var viewModel = PoetGhazalViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // گزینه‌های فیلتر
                HStack {
                    Button(action: {
                        selectedPoet = "بابا طاهر"
                        viewModel.loadGhazals(for: selectedPoet)
                    }) {
                        Text("بابا طاهر")
                            .padding()
                            .background(selectedPoet == "بابا طاهر" ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        selectedPoet = "حافظ"
                        viewModel.loadGhazals(for: selectedPoet)
                    }) {
                        Text("حافظ")
                            .padding()
                            .background(selectedPoet == "حافظ" ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                // لیست غزل‌ها
                List {
                    ForEach(viewModel.filteredGhazals()) { ghazal in
                        if searchText.isEmpty || 
                           ghazal.title.contains(searchText) || 
                           ghazal.content.contains(searchText) {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: 100)
                                .foregroundStyle(.ultraThinMaterial)
                                .overlay(
                                    VStack(alignment: .leading) {
                                        Text(ghazal.title)
                                            .font(.headline)
                                        Text(ghazal.content)
                                            .font(.system(.body, design: .serif))
                                    }
                                    .padding()
                                )
                                .padding(.horizontal, 10)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("جستجو")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic))
            .onAppear {
                viewModel.loadGhazals(for: selectedPoet)
            }
            .onChange(of: selectedPoet) { newValue in
                viewModel.selectedPoet = newValue
            }
        }
    }
}

#Preview {
    SearchView()
}
