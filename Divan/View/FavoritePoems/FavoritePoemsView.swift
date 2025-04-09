import SwiftUI
import Foundation

// نگهداری اطلاعات یک غزل ذخیره شده
struct FavoritePoem: Identifiable, Codable {
    var id: String
    var title: String
    var content: String
    var poet: String
    var vazn: String?
    var link1: String?
    var link2: String?
    var date: Date
}

// مدیریت ذخیره‌سازی غزل‌های مورد علاقه با استفاده از UserDefaults
class FavoriteManager: ObservableObject {
    static let shared = FavoriteManager()
    
    private let favoritesKey = "favoritePoemsKey"
    
    @Published var favoritePoems: [FavoritePoem] = []
    
    init() {
        loadFavorites()
    }
    
    // بارگیری غزل‌های مورد علاقه از UserDefaults
    func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: favoritesKey) {
            if let decoded = try? JSONDecoder().decode([FavoritePoem].self, from: data) {
                self.favoritePoems = decoded
                return
            }
        }
        
        self.favoritePoems = []
    }
    
    // ذخیره یک غزل جدید
    func addFavorite(id: String, title: String, content: String, poet: String, vazn: String? = nil, link1: String? = nil, link2: String? = nil) {
        // بررسی تکراری نبودن
        if !isFavorite(id: id) {
            let newFavorite = FavoritePoem(
                id: id,
                title: title,
                content: content,
                poet: poet,
                vazn: vazn,
                link1: link1,
                link2: link2,
                date: Date()
            )
            
            favoritePoems.append(newFavorite)
            saveFavorites()
        }
    }
    
    // حذف یک غزل از لیست علاقه‌مندی‌ها
    func removeFavorite(id: String) {
        favoritePoems.removeAll { $0.id == id }
        saveFavorites()
    }
    
    // بررسی وجود یک غزل در لیست علاقه‌مندی‌ها
    func isFavorite(id: String) -> Bool {
        return favoritePoems.contains { $0.id == id }
    }
    
    // ذخیره لیست کامل علاقه‌مندی‌ها در UserDefaults
    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favoritePoems) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }
}

// صفحه نمایش غزل‌های مورد علاقه
struct FavoritePoemsView: View {
    @StateObject private var favoriteManager = FavoriteManager.shared
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 0) {
            // نتایج غزل‌های ذخیره شده
            if favoriteManager.favoritePoems.isEmpty {
                emptyStateView
            } else {
                favoritesList
            }
        }
        .navigationTitle("غزل‌های مورد علاقه")
        .onAppear {
            favoriteManager.loadFavorites()
        }
    }
    
    private var favoritesList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(favoriteManager.favoritePoems) { poem in
                    poemCard(poem)
                }
            }
            .padding()
        }
        .background(Color(white: 0.95))
    }
    
    private func poemCard(_ poem: FavoritePoem) -> some View {
        VStack(alignment: .center, spacing: 12) {
            Text(poem.title)
                .font(.headline)
                .foregroundStyle(.primary)
                .lineLimit(1)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            
            Text(poem.content)
                .font(.body)
                .lineLimit(3)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            
            HStack {
                Text(poem.poet)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Button(action: {
                    favoriteManager.removeFavorite(id: poem.id)
                }) {
                    Image(systemName: "trash.fill")
                        .foregroundStyle(.red)
                }
                .buttonStyle(.plain)
            }
        }
        .frame(minHeight: 120)
        .padding()
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart.slash.fill")
                .font(.system(size: 48))
                .foregroundStyle(.secondary)
            
            Text("هنوز غزلی ذخیره نکرده‌اید")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            Text("برای ذخیره غزل‌های مورد علاقه‌تان، از صفحه نمایش غزل استفاده کنید")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(white: 0.95))
    }
}

#Preview {
    NavigationStack {
        FavoritePoemsView()
    }
} 