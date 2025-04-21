import Foundation

class FavoritePoetsManager: ObservableObject {
    @Published private(set) var favoritePoets: Set<String> = []
    private let defaults = UserDefaults.standard
    private let key = "FavoritePoets"
    
    init() {
        if let data = defaults.object(forKey: key) as? Data,
           let poets = try? JSONDecoder().decode(Set<String>.self, from: data) {
            favoritePoets = poets
        }
    }
    
    func toggleFavorite(poetId: String) {
        if favoritePoets.contains(poetId) {
            favoritePoets.remove(poetId)
        } else {
            favoritePoets.insert(poetId)
        }
        
        if let encoded = try? JSONEncoder().encode(favoritePoets) {
            defaults.set(encoded, forKey: key)
        }
    }
    
    func isFavorite(_ poetId: String) -> Bool {
        favoritePoets.contains(poetId)
    }
} 