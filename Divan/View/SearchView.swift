//
//  HafezQListView.swift
//  Divan
//
//  Created by Sothesom on 21/12/1403.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = PoetGhazalViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // نوار جستجو
                HStack {
                    TextField("جستجو...", text: $viewModel.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .onChange(of: viewModel.searchText) { _ in
                            viewModel.search()
                        }
                }
                
                // دکمه تغییر شاعر
                Button(action: {
                    viewModel.switchPoet()
                }) {
                    HStack {
                        Image(systemName: "arrow.triangle.2.circlepath")
                        Text("تغییر به \(viewModel.selectedPoet == .hafez ? "باباطاهر" : "حافظ")")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // نتایج جستجو
                List(viewModel.searchResults) { poem in
                    VStack(alignment: .trailing, spacing: 8) {
                        Text(poem.title)
                            .font(.headline)
                        
                        Text(poem.content)
                            .font(.body)
                            .lineLimit(3)
                        
                        if let vazn = poem.vazn {
                            Text(vazn)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("جستجو در \(viewModel.selectedPoet.rawValue)")
        }
    }
}

#Preview {
    SearchView()
}
