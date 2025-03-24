//
//  DivanViewModel.swift
//  Divan
//
//  Created by Sothesom on 21/12/1403.
//

import Foundation
import SwiftUI

class DivanDBModelView: ObservableObject {
    private let model = DivanDBModel()
    @Published var ghazals: [String] = []
    @Published var errorMessage: String?
    
    init() {
        print("ViewModel ایجاد شد")
        loadGhazals()
    }
    
    func loadGhazals() {
        print("شروع بارگذاری غزل‌ها")
        ghazals = model.readData()
        print("تعداد غزل‌های لود شده: \(ghazals.count)")
        
        if ghazals.isEmpty {
            errorMessage = "هیچ غزلی یافت نشد"
        } else {
            errorMessage = nil
        }
    }
} 
