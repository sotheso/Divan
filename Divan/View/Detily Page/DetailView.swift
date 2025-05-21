import SwiftUI
import SafariServices
import Foundation

// MARK: - You need to add the proper import for SimpleFavoriteManager:
// import or use the correct module name where SimpleFavoriteManager is defined

struct DetailView: View {
    let poem: Poem
    let hidesFavoriteButton: Bool
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    @State private var showSafari = false
    @State private var selectedURL: URL?
    @State private var isFavorite: Bool = false
    @State private var showFavoriteToast = false
    
    init(poem: Poem, hidesFavoriteButton: Bool = false) {
        self.poem = poem
        self.hidesFavoriteButton = hidesFavoriteButton
    }
    
    // MARK: - Local methods to manage favorites
    private func addToFavorites() {
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
        MyPoemSaver.shared.removePoem(id: poem.id.uuidString)
    }
    
    private func checkIsFavorite() -> Bool {
        return MyPoemSaver.shared.isPoemSaved(id: poem.id.uuidString)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
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
                        .foregroundStyle(Color("Color").opacity(0.8))
                }
                
                // دکمه‌های عملیات
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        ShareLink(item: "\(poem.title)\n\n\(poem.content)\n\nوزن: \(poem.vazn ?? "")") {
                            Label {
                                Text("Share")
                                    .font(.callout)
                            } icon: {
                                Image(systemName: "square.and.arrow.up")
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .tint(.blue)
                        
                        if !hidesFavoriteButton {
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
                    }
                    
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
                    
                    // دکمه‌های پادکست
                    if !poem.link1.isEmpty {
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
                    
//                    if !poem.link2.isEmpty {
//                        Button(action: {
//                            if let url = URL(string: poem.link2) {
//                                selectedURL = url
//                                showSafari = true
//                            }
//                        }) {
//                            Label {
//                                Text("Listen on Apple Podcast")
//                                    .font(.callout)
//                            } icon: {
//                                Image("Podcasts")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 24, height: 24)
//                            }
//                            .frame(maxWidth: .infinity)
//                        }
//                        .buttonStyle(.bordered)
//                        .tint(.purple)
//                    }
                }
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color("Color Back"))
                    .shadow(radius: 8, x: 0, y: 4)
            )
            .padding(.horizontal)
            .padding(.top, 100)
        }
        .background(Color("Color Back"))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.backward")
                        Text("Back")
                    }
                    .foregroundStyle(Color("Color"))
                }
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showSafari) {
            if let url = selectedURL {
                safariOpen(url: url)
            }
        }
        .onAppear {
            // بررسی وضعیت ذخیره‌سازی غزل هنگام نمایش
            isFavorite = checkIsFavorite()
        }
        .overlay(
            // نمایش پیام تایید
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
        )
    }
    
    // متد ذخیره‌سازی غزل
    private func savePoem() {
        if isFavorite {
            // اگر قبلاً ذخیره شده بود، حذف می‌کنیم
            removeFromFavorites()
            isFavorite = false
        } else {
            // ذخیره غزل جدید
            addToFavorites()
            isFavorite = true
        }
        
        // نمایش پیام تایید
        withAnimation {
            showFavoriteToast = true
        }
    }
}
