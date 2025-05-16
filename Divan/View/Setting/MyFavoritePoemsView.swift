import SwiftUI

// MARK: - Favorite Poem Card View
private struct FavoritePoemCard: View {
    let poem: MyFavoritePoem
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 12) {
            Text(poem.title)
                .font(.headline)
                .foregroundStyle(.primary)
                .lineLimit(1)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            Text(poem.content)
                .font(.body)
                .lineLimit(3)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            HStack {
                Text(poem.poet)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
    }
}

// MARK: - Main View
struct MyFavoritePoemsView: View {
    @StateObject private var favoriteManager = MyFavoritePoemManager.shared
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedPoet: String? = nil
    
    var filteredPoems: [MyFavoritePoem] {
        if let poet = selectedPoet {
            return favoriteManager.favoritePoems.filter { $0.poet == poet }
        }
        return favoriteManager.favoritePoems
    }
    
    var uniquePoets: [String] {
        Array(Set(favoriteManager.favoritePoems.map { $0.poet })).sorted()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // فیلتر شاعر
            if !favoriteManager.favoritePoems.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(uniquePoets, id: \.self) { poet in
                            FilterChip(title: poet, isSelected: selectedPoet == poet) {
                                selectedPoet = poet
                            }
                        }
                        
                        FilterChip(title: "همه", isSelected: selectedPoet == nil) {
                            selectedPoet = nil
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .background(Color(.secondarySystemGroupedBackground))
                .frame(height: 50)
            }
            
            if filteredPoems.isEmpty {
                emptyStateView
            } else {
                favoritesList
            }
        }
        .navigationTitle("غزل‌های مورد علاقه")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            favoriteManager.loadFavorites()
        }
        .background(Color(.systemGroupedBackground))
    }
    
    private var favoritesList: some View {
        List {
            ForEach(filteredPoems) { poem in
                Button {
                    let detailView = DetailView(
                        poem: Poem(
                            title: poem.title,
                            content: poem.content,
                            vazn: poem.vazn,
                            poet: PoetType(rawValue: poem.poet) ?? .hafez,
                            link1: poem.link1 ?? "",
                            link2: poem.link2 ?? ""
                        ),
                        hidesFavoriteButton: true
                    )
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let window = windowScene.windows.first,
                       let rootViewController = window.rootViewController {
                        let hostingController = UIHostingController(rootView: detailView)
                        rootViewController.present(hostingController, animated: true)
                    }
                } label: {
                    FavoritePoemCard(poem: poem)
                }
                .buttonStyle(PlainButtonStyle())
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color(.systemGroupedBackground))
                .listRowSeparator(.hidden)
                .padding(.horizontal)
                .padding(.vertical, 4)
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        withAnimation {
                            favoriteManager.removeFavorite(id: poem.id)
                        }
                    } label: {
                        Label("حذف", systemImage: "trash.fill")
                    }
                    .tint(.red)
                }
            }
        }
        .listStyle(.plain)
        .background(Color(.systemGroupedBackground))
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart.slash.fill")
                .font(.system(size: 48))
                .foregroundStyle(.secondary)
            
            Text("هنوز غزلی ذخیره نکرده‌اید")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            Text("برای ذخیره غزل‌های مورد علاقه‌تان، از صفحه نمایش غزل استفاده کنید")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}

// کامپوننت فیلتر
struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? .white : .primary)
                .clipShape(Capsule())
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        }
    }
}

#Preview {
    NavigationView {
        MyFavoritePoemsView()
    }
} 
