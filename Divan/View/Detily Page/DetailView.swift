import SwiftUI
import SafariServices
import Foundation

// MARK: - You need to add the proper import for SimpleFavoriteManager:
// import or use the correct module name where SimpleFavoriteManager is defined

struct DetailView: View {
    let poem: Poem
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    @State private var showSafari = false
    @State private var selectedURL: URL?
    @State private var isFavorite: Bool = false
    @State private var showFavoriteToast = false
    
    // MARK: - Local methods to manage favorites
    private func addToFavorites(id: String) {
        SimpleFavoriteManager.shared.addFavorite(id: id)
    }
    
    private func removeFromFavorites(id: String) {
        SimpleFavoriteManager.shared.removeFavorite(id: id)
    }
    
    private func checkIsFavorite(id: String) -> Bool {
        return SimpleFavoriteManager.shared.isFavorite(id: id)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text(poem.title)
                    .font(.system(.title2, design: .serif))
                    .fontWeight(.bold)
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
                
                // دکمه‌های عملیات
                VStack(spacing: 16) {
                    ShareLink(item: "\(poem.title)\n\n\(poem.content)\n\nوزن: \(poem.vazn ?? "")") {
                        Label("اشتراک‌گذاری", systemImage: "square.and.arrow.up")
                    }
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    
                    Button(action: {
                        savePoem()
                    }) {
                        Label(
                            isFavorite ? "حذف از علاقه‌مندی‌ها" : "ذخیره در علاقه‌مندی‌ها", 
                            systemImage: isFavorite ? "heart.fill" : "heart"
                        )
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .tint(isFavorite ? .red : .pink)
                    
                    Text("خوانش غزل")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                    
                    // دکمه‌های پادکست
                    if !poem.link1.isEmpty {
                        Button(action: {
                            if let url = URL(string: poem.link1) {
                                selectedURL = url
                                showSafari = true
                            }
                        }) {
                            Label("گوش دادن در Castbox", systemImage: "headphones")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .tint(.orange)
                    }
                    
                    if !poem.link2.isEmpty {
                        Button(action: {
                            if let url = URL(string: poem.link2) {
                                selectedURL = url
                                showSafari = true
                            }
                        }) {
                            Label("گوش دادن در Apple Podcast", systemImage: "headphones")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .tint(.purple)
                    }
                }
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
                    .shadow(radius: 8, x: 0, y: 4)
            )
            .padding(.horizontal)
            .padding(.top, 100)
        }
        .background(Color(.secondarySystemBackground))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.blue)
                }
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showSafari) {
            if let url = selectedURL {
                SafariView(url: url)
            }
        }
        .onAppear {
            // بررسی وضعیت ذخیره‌سازی غزل هنگام نمایش
            isFavorite = checkIsFavorite(id: poem.id.uuidString)
        }
        .overlay(
            // نمایش پیام تایید
            Group {
                if showFavoriteToast {
                    VStack {
                        Spacer()
                        
                        Text(isFavorite ? "به لیست علاقه‌مندی‌ها اضافه شد" : "از لیست علاقه‌مندی‌ها حذف شد")
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
            removeFromFavorites(id: poem.id.uuidString)
            isFavorite = false
        } else {
            // ذخیره غزل جدید
            addToFavorites(id: poem.id.uuidString)
            isFavorite = true
        }
        
        // نمایش پیام تایید
        withAnimation {
            showFavoriteToast = true
        }
    }
}
