import Foundation

class PoetGhazalViewModel: ObservableObject {
    private let model = PoemModel()
    @Published var searchText = ""
    @Published var searchResults: [Poem] = []
    @Published var selectedPoet: PoetType = .hafez
    @Published var allPoems: [Poem] = []
    
    init() {
        loadPoems()
    }
    
    func loadPoems() {
        allPoems = selectedPoet == .hafez ? model.readHafezData() : model.readBabaTaherData()
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
    
    func switchPoet() {
        selectedPoet = selectedPoet == .hafez ? .babaTaher : .hafez
        loadPoems()
    }
} 