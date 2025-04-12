import SwiftUI
import UserNotifications

struct AlarmView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var settings: AppSettings
    @State private var showWeekDaysPicker = false
    @State private var showPoetsPicker = false
    @State private var showTimePicker = false
    @State private var showNotificationPermissionAlert = false
    
    private let weekDays = ["شنبه", "یکشنبه", "دوشنبه", "سه‌شنبه", "چهارشنبه", "پنج‌شنبه", "جمعه"]
    private let poets = ["حافظ", "سعدی", "مولانا", "خیام", "فردوسی"]
    
    var selectedTimeText: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        formatter.locale = Locale(identifier: "fa_IR")
        return formatter.string(from: settings.dailyReminderTime)
    }
    
    var selectedDaysText: String {
        if settings.selectedDays.isEmpty {
            return "هیچ روزی انتخاب نشده"
        } else {
            return settings.selectedDays.sorted().joined(separator: "، ")
        }
    }
    
    var selectedPoetsText: String {
        if settings.selectedPoets.isEmpty {
            return "هیچ شاعری انتخاب نشده"
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
                            content.title = "شعر روزانه"
                            content.body = "شعر جدیدی از \(poet) برای شما آماده است"
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
                            Text("فعال کردن اعلان‌ها")
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
                                .onChange(of: settings.dailyReminderTime) { _, _ in
                                    if settings.notificationsEnabled {
                                        scheduleNotifications()
                                    }
                                }
                        },
                        label: {
                            HStack {
                                Text("زمان اعلان روزانه")
                                Spacer()
                                Text(selectedTimeText)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    )
                    .disabled(!settings.notificationsEnabled)
                    .opacity(settings.notificationsEnabled ? 1.0 : 0.5)
                    
                    Toggle("اعلان روزانه", isOn: Binding(
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
                }
                
                Section(header: Text("روزهای هفته")) {
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
                                Text("روزهای انتخاب شده")
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
                
                Section(header: Text("شاعران مورد علاقه")) {
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
                                Text("شاعران انتخاب شده")
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
            .navigationTitle("تنظیمات اعلان")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundStyle(.blue)
                    }
                }
            }
            .alert("دسترسی به اعلان‌ها", isPresented: $showNotificationPermissionAlert) {
                Button("تایید", role: .cancel) { }
            } message: {
                Text("برای دریافت اعلان‌ها، لطفاً دسترسی به اعلان‌ها را در تنظیمات دستگاه فعال کنید.")
            }
        }
    }
}

#Preview {
    AlarmView()
        .environmentObject(AppSettings())
} 