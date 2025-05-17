import SwiftUI
import UserNotifications

struct AlarmView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var settings: AppSettings
    @State private var showWeekDaysPicker = false
    @State private var showPoetsPicker = false
    @State private var showTimePicker = false
    @State private var showNotificationPermissionAlert = false
    
    private let weekDays = ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    private let poets = ["حافظ", "سعدی", "مولانا","باباطاهر"]
    
    var selectedTimeText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: settings.dailyReminderTime)
    }
    
    var selectedDaysText: String {
        if settings.selectedDays.isEmpty {
            return "No day selected"
        } else {
            return settings.selectedDays.sorted().joined(separator: "، ")
        }
    }
    
    var selectedPoetsText: String {
        if settings.selectedPoets.isEmpty {
            return "No poet selected"
        } else {
            return settings.selectedPoets.sorted().joined(separator: "، ")
        }
    }
    
    func scheduleNotifications() {
        // درخواست مجوز اعلان
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                // حذف اعلان‌های قبلی
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                // اگر اعلان‌ها فعال هستند
                if settings.notificationsEnabled {
                    // برای هر روز انتخاب شده
                    for day in settings.selectedDays {
                        // برای هر شاعر انتخاب شده
                        for poet in settings.selectedPoets {
                            // ایجاد محتوای اعلان
                            let content = UNMutableNotificationContent()
                            content.title = "Poem Reminder"
                            content.body = "چی میگه \(poet) بزن بیا ببین"
                            content.sound = .default
                            
                            // تنظیم زمان اعلان
                            let calendar = Calendar.current
                            var dateComponents = DateComponents()
                            dateComponents.hour = calendar.component(.hour, from: settings.dailyReminderTime)
                            dateComponents.minute = calendar.component(.minute, from: settings.dailyReminderTime)
                            
                            // تبدیل نام روز به عدد
                            let dayNumber = weekDays.firstIndex(of: day)! + 1
                            dateComponents.weekday = dayNumber
                            
                            // ایجاد trigger
                            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                            
                            // ایجاد درخواست اعلان
                            let request = UNNotificationRequest(
                                identifier: "\(poet)-\(day)",
                                content: content,
                                trigger: trigger
                            )
                            
                            // اضافه کردن درخواست به مرکز اعلان
                            UNUserNotificationCenter.current().add(request)
                        }
                    }
                }
            } else {
                showNotificationPermissionAlert = true
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle(isOn: Binding(
                        get: { settings.notificationsEnabled },
                        set: { newValue in
                            settings.notificationsEnabled = newValue
                            if newValue {
                                scheduleNotifications()
                            } else {
                                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                            }
                        }
                    )) {
                        Label {
                            Text("Turn On Notifications")
                        } icon: {
                            Image(systemName: settings.notificationsEnabled ? "bell.fill" : "bell")
                        }
                    }
                }
                
                Section {
                    
                    DisclosureGroup(
                        isExpanded: $showTimePicker,
                        content: {
                            DatePicker("", selection: $settings.dailyReminderTime, displayedComponents: .hourAndMinute)
                                .datePickerStyle(.wheel)
                                .labelsHidden()
                                .environment(\.locale, Locale(identifier: "en_US"))
                                .onChange(of: settings.dailyReminderTime) { _, _ in
                                    if settings.notificationsEnabled {
                                        scheduleNotifications()
                                    }
                                }
                        },
                        label: {
                            HStack {
                                Text("Notification Time")
                                Spacer()
                                Text(selectedTimeText)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    )
                    .disabled(!settings.notificationsEnabled)
                    .opacity(settings.notificationsEnabled ? 1.0 : 0.5)

                }
                
                Section(header: Text("روزهای هفته")) {
                    
                    Toggle("Daily Notification", isOn: Binding(
                        get: { settings.dailyNotification },
                        set: { newValue in
                            settings.dailyNotification = newValue
                            if newValue {
                                settings.selectedDays = Set(weekDays)
                            } else {
                                settings.selectedDays.removeAll()
                            }
                            if settings.notificationsEnabled {
                                scheduleNotifications()
                            }
                        }
                    ))
                    .disabled(!settings.notificationsEnabled)
                    .opacity(settings.notificationsEnabled ? 1.0 : 0.5)
                    
                    DisclosureGroup(
                        isExpanded: $showWeekDaysPicker,
                        content: {
                            ForEach(weekDays, id: \.self) { day in
                                HStack {
                                    Text(day)
                                    Spacer()
                                    if settings.selectedDays.contains(day) {
                                        Image(systemName: "checkmark")
                                            .foregroundStyle(.blue)
                                    }
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    if settings.selectedDays.contains(day) {
                                        settings.selectedDays.remove(day)
                                        if settings.selectedDays.isEmpty {
                                            settings.dailyNotification = false
                                        }
                                    } else {
                                        settings.selectedDays.insert(day)
                                        if settings.selectedDays.count == weekDays.count {
                                            settings.dailyNotification = true
                                        }
                                    }
                                    if settings.notificationsEnabled {
                                        scheduleNotifications()
                                    }
                                }
                            }
                        },
                        label: {
                            HStack {
                                Text("Selected Days")
                                Spacer()
                                Text(selectedDaysText)
                                    .foregroundStyle(.secondary)
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                    )
                    .disabled(!settings.notificationsEnabled)
                    .opacity(settings.notificationsEnabled ? 1.0 : 0.5)
                }
                
                Section(header: Text("Favorite Poets")) {
                    DisclosureGroup(
                        isExpanded: $showPoetsPicker,
                        content: {
                            ForEach(poets, id: \.self) { poet in
                                HStack {
                                    Text(poet)
                                    Spacer()
                                    if settings.selectedPoets.contains(poet) {
                                        Image(systemName: "checkmark")
                                            .foregroundStyle(.blue)
                                    }
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    if settings.selectedPoets.contains(poet) {
                                        settings.selectedPoets.remove(poet)
                                    } else {
                                        settings.selectedPoets.insert(poet)
                                    }
                                    if settings.notificationsEnabled {
                                        scheduleNotifications()
                                    }
                                }
                            }
                        },
                        label: {
                            HStack {
                                Text("Selected Poets")
                                Spacer()
                                Text(selectedPoetsText)
                                    .foregroundStyle(.secondary)
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                    )
                    .disabled(!settings.notificationsEnabled)
                    .opacity(settings.notificationsEnabled ? 1.0 : 0.5)
                }
            }
            .navigationTitle("Notification Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundStyle(.blue)
                    }
                }
            }
            .alert("Notification Access", isPresented: $showNotificationPermissionAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("To receive notifications, please enable notification access in your device settings.")
            }
        }
    }
}

#Preview {
    AlarmView()
        .environmentObject(AppSettings())
} 
