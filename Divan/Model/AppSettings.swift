import SwiftUI

class AppSettings: ObservableObject {
    @Published var isDarkMode = false
    @Published var fontSize: Double = 1.0
    @Published var isBoldFont = false
    @Published var favoritePoet: String = "حافظ"
    @Published var notificationsEnabled = false
    @Published var dailyNotification = false
    @Published var dailyReminderTime = Date()
    @Published var selectedDays: Set<String> = []
    @Published var selectedPoets: Set<String> = []
    @Published var autoPlayAudio = false
    
    init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        self.fontSize = UserDefaults.standard.double(forKey: "fontSize")
        self.isBoldFont = UserDefaults.standard.bool(forKey: "isBoldFont")
        self.notificationsEnabled = UserDefaults.standard.bool(forKey: "notificationsEnabled")
        self.dailyNotification = UserDefaults.standard.bool(forKey: "dailyNotification")
        self.dailyReminderTime = UserDefaults.standard.object(forKey: "dailyReminderTime") as? Date ?? Date()
        self.selectedDays = Set(UserDefaults.standard.stringArray(forKey: "selectedDays") ?? [])
        self.selectedPoets = Set(UserDefaults.standard.stringArray(forKey: "selectedPoets") ?? [])
    }
    
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