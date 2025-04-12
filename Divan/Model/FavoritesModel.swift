import SwiftUI
import Foundation

class SimpleFavoriteManager: ObservableObject {
    static let shared = SimpleFavoriteManager()
    @Published private(set) var favoriteIds: Set<String> = []
    private let userDefaultsKey = "FavoritePoems"
    
    init() {
        loadFavorites()
    }
    
    private func loadFavorites() {
        if let savedIds = UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] {
            favoriteIds = Set(savedIds)
        }
    }
    
    private func saveFavorites() {
        UserDefaults.standard.set(Array(favoriteIds), forKey: userDefaultsKey)
    }
    
    func addFavorite(_ id: String) {
        favoriteIds.insert(id)
        saveFavorites()
    }
    
    func removeFavorite(_ id: String) {
        favoriteIds.remove(id)
        saveFavorites()
    }
    
    func isFavorite(_ id: String) -> Bool {
        favoriteIds.contains(id)
    }
    
    func getFavorites() -> [String] {
        Array(favoriteIds)
    }
}

class FavoritesViewModel: ObservableObject {
    @Published var poems: [Poem] = []
    private let model = PoemModel()
    
    init() {
        loadPoems()
    }
    
    func loadPoems() {
        model.selectedPoet = .hafez
        let hafezPoems = model.readHafezData()
        
        model.selectedPoet = .babaTaher
        let babaTaherPoems = model.readBabaTaherData()
        
        poems = hafezPoems + babaTaherPoems
    }
    
    func findPoemById(_ id: String) -> Poem? {
        poems.first(where: { $0.title == id })
    }
} 