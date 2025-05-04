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
    
    static let sampleBooks: [Book] = [
        Book(
            title: "کلیات سعدی",
            author: "سعدی شیرازی",
            imageName: "BookSample",
            description: "مجموعه کامل آثار سعدی شامل بوستان، گلستان، غزلیات و قصاید",
            poetType: .saadi,
            category: .saadiGhazal,
            year: 690
        ),
        Book(
            title: "دیوان حافظ",
            author: "حافظ شیرازی",
            imageName: "BookSample",
            description: "مجموعه غزلیات، قصاید و رباعیات حافظ شیرازی",
            poetType: .hafez,
            category: .hafezGhazal,
            year: 792
        ),
        Book(
            title: "مثنوی معنوی",
            author: "مولانا جلال‌الدین بلخی",
            imageName: "BookSample",
            description: "شش دفتر شعر مثنوی معنوی مولانا",
            poetType: .molana,
            category: .masnavi,
            year: 672
        ),
        Book(
            title: "دوبیتی‌های باباطاهر",
            author: "باباطاهر عریان",
            imageName: "BookSample",
            description: "مجموعه دوبیتی‌های باباطاهر همدانی",
            poetType: .babaTaher,
            category: .babaTaherDoBeyti,
            year: 1055
        )
    ]
}

class BookModel: ObservableObject {
    @Published var books: [Book] = Book.sampleBooks
    
    func getBooksByPoet(_ poetType: PoetType) -> [Book] {
        return books.filter { $0.poetType == poetType }
    }
    
    func getBooksByCategory(_ category: PoemCategory) -> [Book] {
        return books.filter { $0.category == category }
    }
} 
