import Foundation

class PoetGhazalViewModel: ObservableObject {
    private let model = PoemModel()
    @Published var searchText = ""
    @Published var searchResults: [Poem] = []
    @Published var selectedCategory: PoemCategory = .hafezGhazal {
        didSet { loadPoems() }
    }
    @Published var allPoems: [Poem] = []
    
    init() {
        loadPoems()
    }
    
    func loadPoems() {
        model.selectedCategory = selectedCategory
        allPoems = model.searchResults
        searchResults = allPoems
    }
    
    func search() {
        if searchText.isEmpty {
            searchResults = allPoems
        } else {
            searchResults = allPoems.filter { poem in
                poem.title.contains(searchText) || poem.content.contains(searchText)
            }
        }
    }
    
    func switchCategory(to category: PoemCategory) {
        selectedCategory = category
    }
} 