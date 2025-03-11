//
//  HafezQListView.swift
//  Divan
//
//  Created by Sothesom on 21/12/1403.
//

import SwiftUI

struct HafezQListView: View {
    
    @StateObject private var viewModel = DivanViewModel()
    @State private var searchText = ""
    
    var filteredGhazals: [String] {
        if searchText.isEmpty {
            return viewModel.ghazals
        } else {
            return viewModel.ghazals.filter { $0.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // سرچ بار
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("جستجو در غزل‌ها...", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemGray6))
                )
                .padding(.horizontal)
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else if viewModel.ghazals.isEmpty {
                    Text("در حال بارگذاری...")
                        .font(.system(.body, design: .serif))
                } else {
                    List {
                        ForEach(filteredGhazals, id: \.self) { ghazal in
                            Text(ghazal)
                                .padding(.vertical, 8)
                                .font(.system(.body, design: .serif))
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("دیوان حافظ")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                // اطمینان از لود شدن مجدد داده‌ها
                viewModel.loadGhazals()
            }
        }
    }
}

#Preview {
    HafezQListView()
}
