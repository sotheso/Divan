import Foundation

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

class PoemModel {
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