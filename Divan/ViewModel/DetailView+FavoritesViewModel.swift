import SwiftUI
import Foundation

// Simple favorite manager for storing poem IDs
public class SimpleFavoriteManager {
    public static let shared = SimpleFavoriteManager()
    private let favoritesKey = "simpleFavoritePoemsKey"
    
    // Save a poem ID as favorite
    public func addFavorite(id: String) {
        var favorites = getFavorites()
        favorites.insert(id)
        saveFavorites(favorites)
    }
    
    // Remove a poem ID from favorites
    public func removeFavorite(id: String) {
        var favorites = getFavorites()
        favorites.remove(id)
        saveFavorites(favorites)
    }
    
    // Check if a poem ID is in favorites
    public func isFavorite(id: String) -> Bool {
        return getFavorites().contains(id)
    }
    
    // Get the set of favorite poem IDs
    public func getFavorites() -> Set<String> {
        if let data = UserDefaults.standard.data(forKey: favoritesKey),
           let favorites = try? JSONDecoder().decode(Set<String>.self, from: data) {
            return favorites
        }
        return []
    }
    
    // Save the set of favorite poem IDs
    private func saveFavorites(_ favorites: Set<String>) {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }
}

// A view to display the list of favorite poem IDs
public struct FavoriteIdsView: View {
    @State private var favoriteIds: [String] = []
    @Environment(\.colorScheme) var colorScheme
    
    public init() {}
    
    public var body: some View {
        VStack {
            if favoriteIds.isEmpty {
                emptyStateView
            } else {
                favoriteListView
            }
        }
        .navigationTitle("غزل‌های مورد علاقه")
        .onAppear {
            loadFavorites()
        }
    }
    
    private var favoriteListView: some View {
        List {
            ForEach(favoriteIds, id: \.self) { id in
                Text("غزل با شناسه: \(id)")
            }
            .onDelete { indexSet in
                for index in indexSet {
                    let id = favoriteIds[index]
                    SimpleFavoriteManager.shared.removeFavorite(id: id)
                }
                loadFavorites()
            }
        }
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
    }
    
    private func loadFavorites() {
        favoriteIds = Array(SimpleFavoriteManager.shared.getFavorites())
    }
} 