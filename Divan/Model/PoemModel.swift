import Foundation
import SwiftUI

struct Poem: Identifiable {
    let id = UUID()
    let title: String
    let content: String
    let vazn: String?
    let poet: PoetType
}

enum PoetType: String {
    case hafez = "حافظ"
    case babaTaher = "باباطاهر"
}

class PoemModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedPoet: PoetType = .hafez
    @Published var searchResults: [Poem] = []
    
    private var allPoems: [Poem] = []
    
    init() {
        loadPoems()
    }
    
    private func loadPoems() {
        switch selectedPoet {
        case .hafez:
            allPoems = readHafezData()
        case .babaTaher:
            allPoems = readBabaTaherData()
        }
        search()
    }
    
    func search() {
        if searchText.isEmpty {
            searchResults = allPoems
        } else {
            searchResults = allPoems.filter { poem in
                poem.title.contains(searchText) ||
                poem.content.contains(searchText) ||
                (poem.vazn?.contains(searchText) ?? false)
            }
        }
    }
    
    func switchPoet() {
        selectedPoet = selectedPoet == .hafez ? .babaTaher : .hafez
        loadPoems()
    }
    
    func readHafezData() -> [Poem] {
        // خواندن داده‌های حافظ از JSON
        guard let url = Bundle.main.url(forResource: "HafezQazal", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            return []
        }
        
        return json.compactMap { item in
            guard let title = item["title"] as? String,
                  let content = item["content"] as? String else {
                return nil
            }
            return Poem(title: title, content: content, vazn: item["vazn"] as? String, poet: .hafez)
        }
    }
    
    func readBabaTaherData() -> [Poem] {
        // خواندن داده‌های باباطاهر از JSON
        guard let url = Bundle.main.url(forResource: "BabaTaher2B", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            return []
        }
        
        return json.compactMap { item in
            guard let title = item["title"] as? String,
                  let content = item["content"] as? String else {
                return nil
            }
            return Poem(title: title, content: content, vazn: item["vazn"] as? String, poet: .babaTaher)
        }
    }
} 