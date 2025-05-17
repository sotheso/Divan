import SwiftUI

struct FavoritePoetsView: View {
    @StateObject private var favoritesManager = FavoritePoetsManager()
    let poets: [Poet]
    
    var favoritePoets: [Poet] {
        poets.filter { favoritesManager.isFavorite($0.id.uuidString) }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if favoritePoets.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "star.slash.fill")
                        .font(.system(size: 48))
                        .foregroundStyle(.secondary)
                    
                    Text("No poets have been added to your favorites yet.")                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                    Text("برای افزودن شاعران مورد علاقه، از صفحه پروفایل شاعر استفاده کنید")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemGroupedBackground))
            } else {
                List {
                    ForEach(favoritePoets) { poet in
                        NavigationLink(destination: PoetProfileView(poet: poet)) {
                            HStack {
                                VStack(alignment: .trailing) {
                                    Text(poet.name)
                                        .font(.headline)
                                    Text("\(poet.birthYear) - \(poet.deathYear)")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                                
                                Image(poet.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Favorite Poets")
    }
}

#Preview {
    NavigationStack {
        FavoritePoetsView(poets: Poet.samplePoets)
    }
} 
