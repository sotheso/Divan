import SwiftUI
import SafariServices

struct DetailView: View {
    let poem: Poem
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    @State private var showSafari = false
    @State private var selectedURL: URL?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text(poem.title)
                    .font(.system(.title2, design: .serif))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                
                Text(poem.content)
                    .font(.system(.body, design: .serif))
                    .multilineTextAlignment(.center)
                    .lineSpacing(8)
                
                if let vazn = poem.vazn {
                    Text(vazn)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                // دکمه‌های عملیات
                VStack(spacing: 16) {
                    ShareLink(item: "\(poem.title)\n\n\(poem.content)\n\nوزن: \(poem.vazn ?? "")") {
                        Label("اشتراک‌گذاری", systemImage: "square.and.arrow.up")
                    }
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    
                    Text("خوانش غزل")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                    
                    // دکمه‌های پادکست
                    if !poem.link1.isEmpty {
                        Button(action: {
                            if let url = URL(string: poem.link1) {
                                selectedURL = url
                                showSafari = true
                            }
                        }) {
                            Label("گوش دادن در Castbox", systemImage: "headphones")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .tint(.orange)
                    }
                    
                    if !poem.link2.isEmpty {
                        Button(action: {
                            if let url = URL(string: poem.link2) {
                                selectedURL = url
                                showSafari = true
                            }
                        }) {
                            Label("گوش دادن در Apple Podcast", systemImage: "headphones")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .tint(.purple)
                    }
                }
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
                    .shadow(radius: 8, x: 0, y: 4)
            )
            .padding(.horizontal)
            .padding(.top, 100)
        }
        .background(Color(.secondarySystemBackground))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.blue)
                }
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showSafari) {
            if let url = selectedURL {
                SafariView(url: url)
            }
        }
    }
}
