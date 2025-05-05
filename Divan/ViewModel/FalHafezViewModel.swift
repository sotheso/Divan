import Foundation

class FalHafezViewModel: ObservableObject {
    private let model = PoemModel()
    @Published var selectedPoem: Poem?
    @Published var poems: [Poem] = []
    @Published var selectedCategory: PoemCategory = .hafezGhazal {
        didSet { loadPoems() }
    }
    @Published var isLoading = false
    @Published var error: Error?
    
    init() {
        loadPoems()
    }
    
    func loadPoems() {
        model.selectedCategory = selectedCategory
        model.loadPoems()
        poems = model.allPoems
    }
    
    func getRandomPoem() {
        guard !poems.isEmpty else { return }
        selectedPoem = poems.randomElement()
    }
    
    func switchCategory(to category: PoemCategory) {
        selectedCategory = category
    }
} 
