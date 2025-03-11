import Foundation
import SwiftUI

class DivanViewModel: ObservableObject {
    private let model = DivanModel()
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