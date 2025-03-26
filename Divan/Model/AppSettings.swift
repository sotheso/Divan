import SwiftUI

class AppSettings: ObservableObject {
    @Published var isDarkMode = false
    @Published var fontSize: Double = 1.0
    @Published var isBoldFont = false
    @Published var favoritePoet: String = "حافظ"
    @Published var notificationsEnabled = true
    @Published var dailyReminderTime = Date()
    @Published var autoPlayAudio = false
    
    // Font size multiplier for different text styles
    func fontSizeMultiplier(_ size: CGFloat) -> CGFloat {
        return size * fontSize
    }
    
    // Font weight based on bold setting
    var fontWeight: Font.Weight {
        return isBoldFont ? .bold : .regular
    }
}

struct DynamicFontModifier: ViewModifier {
    @EnvironmentObject var settings: AppSettings
    let baseSize: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: baseSize * settings.fontSize))
            .fontWeight(settings.isBoldFont ? .bold : .regular)
    }
}

extension View {
    func dynamicFont(baseSize: CGFloat = 16) -> some View {
        modifier(DynamicFontModifier(baseSize: baseSize))
    }
} 