import SwiftUI

struct MyFavoritePoem: Identifiable, Codable {
    var id: String
    var title: String
    var content: String
    var poet: String
    var vazn: String?
    var link1: String?
    var link2: String?
    var date: Date
}

class MyFavoritePoemManager: ObservableObject {
    static let shared = MyFavoritePoemManager()
    
    private let favoritesKey = "myFavoritePoemsKey"
    
    @Published var favoritePoems: [MyFavoritePoem] = []
    
    private init() {
        loadFavorites()
    }
    
    func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: favoritesKey) {
            if let decoded = try? JSONDecoder().decode([MyFavoritePoem].self, from: data) {
                self.favoritePoems = decoded
                return
            }
        }
        self.favoritePoems = []
    }
    
    func addFavorite(id: String, title: String, content: String, poet: String, vazn: String? = nil, link1: String? = nil, link2: String? = nil) {
        if !favoritePoems.contains(where: { $0.title == title && $0.content == content }) {
            let newFavorite = MyFavoritePoem(
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
    
    func removeFavorite(id: String) {
        favoritePoems.removeAll { $0.id == id }
        saveFavorites()
    }
    
    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favoritePoems) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }
} 