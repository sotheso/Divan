import SwiftUI
import SafariServices
import Foundation

// MARK: - You need to add the proper import for SimpleFavoriteManager:
// import or use the correct module name where SimpleFavoriteManager is defined

struct DetailView: View {
    let poem: Poem
    let hidesFavoriteButton: Bool
    let showBackButton: Bool
    let onBackButtonPressed: (() -> Void)?
    let disableTopPadding: Bool
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    @State private var showSafari = false
    @State private var selectedURL: URL?
    @State private var isFavorite: Bool = false
    @State private var showFavoriteToast = false
    
    init(
        poem: Poem, 
        hidesFavoriteButton: Bool = false,
        showBackButton: Bool = false,
        onBackButtonPressed: (() -> Void)? = nil,
        disableTopPadding: Bool = false
    ) {
        self.poem = poem
        self.hidesFavoriteButton = hidesFavoriteButton
        self.showBackButton = showBackButton
        self.onBackButtonPressed = onBackButtonPressed
        self.disableTopPadding = disableTopPadding
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
            poemContentView
                .padding(24)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color("Color Back"))
                        .shadow(radius: 8, x: 0, y: 4)
                )
                .padding(.horizontal)
                .padding(.top, disableTopPadding ? 0 : 20)
                .padding(.bottom, 20)
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
        .ignoresSafeArea(disableTopPadding ? [] : .container, edges: .top)
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
            favoriteToastView
        )
    }
    
    // MARK: - Subviews
    
    private var poemContentView: some View {
        VStack(spacing: 24) {
            // عنوان و متن شعر
            poemHeaderView
            
            // دکمه‌های عملیات
            actionButtonsView
        }
    }
    
    private var poemHeaderView: some View {
        VStack(spacing: 16) {
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
        }
    }
    
    private var actionButtonsView: some View {
        VStack(spacing: 16) {
            // دکمه‌های اشتراک‌گذاری و ذخیره
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
            
            // خط جداکننده با متن
            dividerWithTextView
            
            // دکمه‌های پیوند
            linksView
        }
    }
    
    private var dividerWithTextView: some View {
        HStack {
            // خط سمت چپ
            Rectangle()
                .fill(Color("Color").opacity(0.3))
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
                .fill(Color("Color").opacity(0.3))
                .frame(height: 1)
        }
        .padding(.vertical, 8)
    }
    
    private var linksView: some View {
        VStack(spacing: 12) {
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
            
            if showBackButton {
                Button(action: {
                    if let action = onBackButtonPressed {
                        action()
                    }
                }) {
                    Label("Back", systemImage: "arrow.counterclockwise")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .tint(Color("Color"))
            }
        }
    }
    
    private var favoriteToastView: some View {
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
    
    private func safariOpen(url: URL) -> some View {
        SafariView(url: url)
    }
}

// MARK: - Safari View
struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        // No update needed
    }
}
