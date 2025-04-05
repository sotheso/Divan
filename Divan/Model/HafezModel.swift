//
//  HafezGhazal 2.swift
//  TestDiv
//
//  Created by Sothesom on 16/01/1404.
//


import Foundation

struct HafezGhazal: Codable, Hashable {
    let id: String
    let content: String
    let title: String
    let vazn: String?
    let voice: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: HafezGhazal, rhs: HafezGhazal) -> Bool {
        return lhs.id == rhs.id
    }
}

class HafezModel {
    func readData() -> [HafezGhazal] {
        guard let url = Bundle.main.url(forResource: "HafezQazal", withExtension: "json") else {
            print("فایل JSON یافت نشد")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let ghazals = try decoder.decode([HafezGhazal].self, from: data)
            return ghazals
        } catch {
            print("خطا در خواندن فایل JSON: \(error)")
            return []
        }
    }
}