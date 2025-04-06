////
////  File.swift
////  TestDiv
////
////  Created by Sothesom on 16/01/1404.
////
//
//import Foundation
//
//struct BabaTaherGhazal: Codable, Hashable {
//    let alarm: String?
//    let content: String
//    let id: String
//    let link: String?
//    let share: String?
//    let title: String
//    let vazn: String
//    let voice: String?
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//    
//    static func == (lhs: BabaTaherGhazal, rhs: BabaTaherGhazal) -> Bool {
//        return lhs.id == rhs.id
//    }
//}
//
//class BabaTaherModel {
//    func readData() -> [BabaTaherGhazal] {
//        guard let url = Bundle.main.url(forResource: "BabaTaher2B", withExtension: "json") else {
//            print("فایل JSON یافت نشد")
//            return []
//        }
//        
//        do {
//            let data = try Data(contentsOf: url)
//            let decoder = JSONDecoder()
//            let ghazals = try decoder.decode([BabaTaherGhazal].self, from: data)
//            return ghazals
//        } catch {
//            print("خطا در خواندن فایل JSON: \(error)")
//            return []
//        }
//    }
//}
