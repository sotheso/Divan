import SwiftUI

struct Book: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let imageName: String
    let description: String
    let poetType: PoetType
    let category: PoemCategory
    let year: Int
}

class BookModel: ObservableObject {
    @Published var books: [Book] = []
    private let bookImages = ["Book1", "Book2", "Book3", "Book4", "Book5", "Book6"]
    
    init() {
        loadBooks()
    }
    
    private func getBookImage(for index: Int) -> String {
        return bookImages[index % bookImages.count]
    }
    
    func loadBooks() {
        var loadedBooks: [Book] = []
        
        // Load books based on PoemCategory
        for category in PoemCategory.allCases {
            let jsonFileName: String
            switch category {
            case .hafezGhazal: jsonFileName = "HafezQazal"
            case .hafezGhete: jsonFileName = "HafezGhete"
            case .hafezRobaee: jsonFileName = "HafezRobaee"
            case .saadiGhazal: jsonFileName = "SaadiQazal"
            case .saadiBostan: jsonFileName = "Saad‌iBostan"
            case .molanaRobaee: jsonFileName = "DivnanShamsRobaee"
            case .babaTaherDoBeyti: jsonFileName = "BabaTaher2B"
            case .masnavi: jsonFileName = "masnavi"
            }
            
            if Bundle.main.url(forResource: jsonFileName, withExtension: "json") != nil {
                let poetName: String
                let year: Int
                
                switch category {
                case .hafezGhazal, .hafezGhete, .hafezRobaee:
                    poetName = "حافظ شیرازی"
                    year = 792
                case .saadiGhazal, .saadiBostan:
                    poetName = "سعدی شیرازی"
                    year = category == .saadiBostan ? 655 : 690
                case .molanaRobaee, .masnavi:
                    poetName = "مولانا جلال‌الدین بلخی"
                    year = 672
                case .babaTaherDoBeyti:
                    poetName = "باباطاهر عریان"
                    year = 1055
                }
                
                loadedBooks.append(Book(
                    title: category.displayName,
                    author: poetName,
                    imageName: getBookImage(for: loadedBooks.count),
                    description: "مجموعه \(category.displayName)",
                    poetType: category.poetType,
                    category: category,
                    year: year
                ))
            }
        }
        
        books = loadedBooks
    }
    
    func getBooksByPoet(_ poetType: PoetType) -> [Book] {
        return books.filter { $0.poetType == poetType }
    }
    
    func getBooksByCategory(_ category: PoemCategory) -> [Book] {
        return books.filter { $0.category == category }
    }
} 
