//
//  FalView.swift
//  TestDiv
//
//  Created by Sothesom on 22/12/1403.
//

import SwiftUI

struct FalHafezView: View {
    @StateObject private var viewModel = FalHafezViewModel()
    @State private var hasTakenFal = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
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
                
                if let poem = viewModel.selectedPoem {
                    ScrollView {
                        VStack(alignment: .trailing, spacing: 16) {
                            Text(poem.title)
                                .font(.headline)
                                .multilineTextAlignment(.trailing)
                            
                            Text(poem.content)
                                .multilineTextAlignment(.trailing)
                                .font(.system(.body, design: .serif))
                            
                            if let vazn = poem.vazn {
                                Text(vazn)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                    }
                    
                    HStack(spacing: 12) {
                        // دکمه اشتراک‌گذاری
                        ShareLink(item: "\(poem.title)\n\n\(poem.content)\n\nوزن: \(poem.vazn ?? "")") {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                Text("اشتراک‌گذاری")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10)
                        }
                        
                        // دکمه فال جدید
                        Button(action: {
                            viewModel.selectedPoem = nil
                            hasTakenFal = false
                        }) {
                            HStack {
                                Image(systemName: "arrow.counterclockwise")
                                Text("فال جدید")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    
                } else {
                    Image(systemName: "book.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                        .padding()
                    
                    Text("برای گرفتن فال، دکمه زیر را لمس کنید")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        viewModel.getRandomPoem()
                        hasTakenFal = true
                    }) {
                        HStack {
                            Image(systemName: "sparkles")
                            Text("فال \(viewModel.selectedPoet.rawValue)")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("فال \(viewModel.selectedPoet.rawValue)")
        }
    }
}

#Preview {
    FalHafezView()
}
