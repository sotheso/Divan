
import SwiftUI

struct AppColors {
    // رنگ‌های اصلی از Assets
    static let accent = Color("AccentColor")  // رنگ تاکیدی تعریف شده در Assets
    static let primary = Color("Color")       // رنگ اصلی تعریف شده در Assets
    
    // رنگ‌های مشتق شده
    static let primaryLight = primary.opacity(0.7)
    static let accentLight = accent.opacity(0.3)
    
    // رنگ‌های سیستمی
    static let background = Color(.systemBackground)
    static let secondaryBackground = Color(.secondarySystemBackground)
    static let text = Color(.label)
    static let secondaryText = Color(.secondaryLabel)
} 
