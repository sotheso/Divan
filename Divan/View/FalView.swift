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
                if let ghazal = viewModel.selectedGhazal {
                    ScrollView {
                        VStack(alignment: .trailing, spacing: 16) {
                            Text(ghazal.title)
                                .font(.headline)
                                .multilineTextAlignment(.trailing)
                            
                            Text(ghazal.content)
                                .multilineTextAlignment(.trailing)
                                .font(.system(.body, design: .serif))
                            
                            Text(ghazal.vazn)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding()
                    }
                    
                    HStack(spacing: 12) {
                        // دکمه اشتراک‌گذاری
                        ShareLink(item: "\(ghazal.title)\n\n\(ghazal.content)\n\nوزن: \(ghazal.vazn)") {
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
                            viewModel.selectedGhazal = nil
                            hasTakenFal = false
                        }) {
                            HStack {
                                Image(systemName: "arrow.counterclockwise")
                                Text("برگشت")
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
                        viewModel.getRandomGhazal()
                        hasTakenFal = true
                    }) {
                        HStack {
                            Image(systemName: "sparkles")
                            Text("فال حافظ")
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
            .navigationTitle("فال حافظ")
        }
    }
}

#Preview {
    FalHafezView()
}
