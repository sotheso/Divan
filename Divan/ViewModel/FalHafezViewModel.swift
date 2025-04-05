//
//  FalHafezViewModel.swift
//  Divan
//
//  Created by Sothesom on 04/01/1404.
//

import Foundation

class FalHafezViewModel: ObservableObject {
    private let model = HafezModel()
    @Published var selectedGhazal: HafezGhazal?
    @Published var ghazals: [HafezGhazal] = []
    
    init() {
        loadGhazals()
    }
    
    func loadGhazals() {
        ghazals = model.readData()
        print("تعداد غزل‌های حافظ لود شده: \(ghazals.count)")
    }
    
    func getRandomGhazal() {
        guard !ghazals.isEmpty else { return }
        selectedGhazal = ghazals.randomElement()
    }
}

