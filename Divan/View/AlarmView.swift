import SwiftUI

struct AlarmView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var settings: AppSettings
    @State private var showWeekDaysPicker = false
    @State private var showPoetsPicker = false
    
    private let weekDays = ["شنبه", "یکشنبه", "دوشنبه", "سه‌شنبه", "چهارشنبه", "پنج‌شنبه", "جمعه"]
    private let poets = ["حافظ", "سعدی", "مولانا", "خیام", "فردوسی"]
    
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
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle(isOn: $settings.notificationsEnabled) {
                        Label {
                            Text("فعال کردن اعلان‌ها")
                        } icon: {
                            Image(systemName: settings.notificationsEnabled ? "bell.fill" : "bell")
                        }
                    }
                }
                
                Section {
                    DatePicker("زمان اعلان روزانه", selection: $settings.dailyReminderTime, displayedComponents: .hourAndMinute)
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
        }
    }
}

#Preview {
    AlarmView()
        .environmentObject(AppSettings())
} 