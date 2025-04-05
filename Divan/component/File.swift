import Foundation
import SwiftUI

struct PoetGhazal: Identifiable, Hashable {
    let id: String
    let poet: String
    let content: String
    let title: String
    let vazn: String?
    let voice: String?
    
    init(from babaTaherGhazal: BabaTaherGhazal, poet: String) {
        self.id = babaTaherGhazal.id
        self.poet = poet
        self.content = babaTaherGhazal.content
        self.title = babaTaherGhazal.title
        self.vazn = babaTaherGhazal.vazn
        self.voice = babaTaherGhazal.voice
    }
    
    init(from hafezGhazal: HafezGhazal, poet: String) {
        self.id = hafezGhazal.id
        self.poet = poet
        self.content = hafezGhazal.content
        self.title = hafezGhazal.title
        self.vazn = hafezGhazal.vazn
        self.voice = hafezGhazal.voice
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: PoetGhazal, rhs: PoetGhazal) -> Bool {
        return lhs.id == rhs.id
    }
}

class PoetGhazalModel {
    private let babaTaherModel = BabaTaherModel()
    private let hafezViewModel = HafezModel()
    
    func readData(for poet: String) -> [PoetGhazal] {
        if poet == "بابا طاهر" {
            let babaTaherGhazals = babaTaherModel.readData()
            return babaTaherGhazals.map { ghazal in
                PoetGhazal(from: ghazal, poet: poet)
            }
        } else if poet == "حافظ" {
            let hafezGhazals = hafezViewModel.readData()
            return hafezGhazals.map { ghazal in
                PoetGhazal(from: ghazal, poet: poet)
            }
        }
        
        return []
    }
}

class PoetGhazalViewModel: ObservableObject {
    private let model = PoetGhazalModel()
    @Published var ghazals: [PoetGhazal] = []
    @Published var errorMessage: String?
    @Published var selectedPoet: String = ""
    
    init() {
        print("ViewModel ایجاد شد")
    }
    
    func loadGhazals(for poet: String) {
        print("شروع بارگذاری غزل‌ها برای \(poet)")
        ghazals = model.readData(for: poet)
        print("تعداد غزل‌های لود شده: \(ghazals.count)")
        
        if ghazals.isEmpty {
            errorMessage = "هیچ غزلی یافت نشد"
        } else {
            errorMessage = nil
        }
    }
    
    func filteredGhazals() -> [PoetGhazal] {
        return ghazals
    }
} 
