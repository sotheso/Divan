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
    
    var body: some View {
        VStack(spacing: 0) {
            if favoriteManager.favoritePoems.isEmpty {
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
            ForEach(favoriteManager.favoritePoems) { poem in
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
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
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

#Preview {
    NavigationView {
        MyFavoritePoemsView()
    }
} 
