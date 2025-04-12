import SwiftUI

class MyPoemSaver: ObservableObject {
    static let shared = MyPoemSaver()
    
    private init() {}
    
    func savePoem(id: String, title: String, content: String, poet: String, vazn: String? = nil, link1: String? = nil, link2: String? = nil) {
        MyFavoritePoemManager.shared.addFavorite(
            id: id,
            title: title,
            content: content,
            poet: poet,
            vazn: vazn,
            link1: link1,
            link2: link2
        )
    }
    
    func removePoem(id: String) {
        MyFavoritePoemManager.shared.removeFavorite(id: id)
    }
    
    func isPoemSaved(id: String) -> Bool {
        return MyFavoritePoemManager.shared.favoritePoems.contains { $0.id == id }
    }
} 