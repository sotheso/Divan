import Foundation

class FalHafezViewModel: ObservableObject {
    private let model = PoemModel()
    @Published var selectedPoem: Poem?
    @Published var hafezPoems: [Poem] = []
    @Published var babaTaherPoems: [Poem] = []
    @Published var selectedPoet: PoetType = .hafez
    
    init() {
        loadPoems()
    }
    
    func loadPoems() {
        hafezPoems = model.readHafezData()
        babaTaherPoems = model.readBabaTaherData()
        print("تعداد غزل‌های حافظ: \(hafezPoems.count)")
        print("تعداد غزل‌های باباطاهر: \(babaTaherPoems.count)")
    }
    
    func getRandomPoem() {
        let poems = selectedPoet == .hafez ? hafezPoems : babaTaherPoems
        guard !poems.isEmpty else { return }
        selectedPoem = poems.randomElement()
    }
    
    func switchPoet() {
        selectedPoet = selectedPoet == .hafez ? .babaTaher : .hafez
        selectedPoem = nil
    }
} 
