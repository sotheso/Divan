//
//  FalHafezViewModel.swift
//  Divan
//
//  Created by Sothesom on 04/01/1404.
//

import Foundation

class FalHafezViewModel: ObservableObject {
    @Published var selectedGhazal: HafezGhazal?
    private var ghazals: [HafezGhazal] = []
    
    init() {
        loadGhazals()
    }
    
    private func loadGhazals() {
        if let url = Bundle.main.url(forResource: "HafezQazal", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                ghazals = try JSONDecoder().decode([HafezGhazal].self, from: data)
                print("تعداد غزل‌های بارگذاری شده: \(ghazals.count)")
            } catch {
                print("خطا در خواندن فایل JSON: \(error)")
            }
        }
    }
    
    func getRandomGhazal() {
        guard !ghazals.isEmpty else { return }
        selectedGhazal = ghazals.randomElement()
    }
}

