// ProfileView شاعران
// 1404/01/24




import SwiftUI


struct PoetProfileView: View {
    let poet: Poet
    @StateObject private var favoritesManager = FavoritePoetsManager()
    @Environment(\.dismiss) private var dismiss
    @State private var showAlert = false
    @State private var isAddedToFavorites = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                GeometryReader { geometry in
                    ZStack(alignment: .top) {
                        // Background Image
                        Image(poet.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width,
                                   height: (geometry.size.width * 7) / 5)
                            .clipped()
                            .ignoresSafeArea(.all, edges: .top)
                        
                        VStack {
                            // Custom Back Button
                            HStack {
                                Button(action: { dismiss() }) {
                                    HStack {
                                        Image(systemName: "chevron.backward")
                                        Text("بازگشت")
                                    }
                                    .foregroundStyle(.white)
                                    .padding(8)
                                    .background(.black.opacity(0.3))
                                    .clipShape(Capsule())
                                }
                                Spacer()
                            }
                            .padding(.top, 50)
                            .padding()
                            
                            Spacer()
                            
                            // Gradient and Poet Info
                            ZStack(alignment: .bottom) {
                                // Gradient overlay
                                LinearGradient(
                                    gradient: Gradient(colors: [.black.opacity(0.7), .clear]),
                                    startPoint: .bottom,
                                    endPoint: .top
                                )
                                .frame(height: ((geometry.size.width * 7) / 5) * 4 / 7)
                                
                                // Poet info
                                VStack(spacing: 8) {
                                    HStack {
                                        Button(action: {
                                            isAddedToFavorites = !favoritesManager.isFavorite(poet.id.uuidString)
                                            favoritesManager.toggleFavorite(poetId: poet.id.uuidString)
                                            showAlert = true
                                        }) {
                                            Image(systemName: favoritesManager.isFavorite(poet.id.uuidString) ? "star.fill" : "star")
                                                .foregroundStyle(Color.yellow)
                                                .font(.title2)
                                        }
                                        
                                        Text(poet.name)
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                    }
                                    
                                    Text("\(poet.birthPlace) - \(poet.birthYear) تا \(poet.deathYear)")
                                        .font(.subheadline)
                                        .foregroundStyle(.white.opacity(0.9))
                                }
                                .padding(.bottom, 20)
                            }
                        }
                    }
                }
                .frame(height: UIScreen.main.bounds.width * 7 / 5)
                
                // Bio Section
                VStack(alignment: .trailing, spacing: 12) {
                    Text("زندگینامه")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Text(poet.bio)
                        .font(.body)
                        .multilineTextAlignment(.trailing)
                        .lineSpacing(8)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.background)
                        .shadow(radius: 2)
                )
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Works Section
                VStack(alignment: .trailing, spacing: 12) {
                    Text("آثار")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    ForEach(poet.works, id: \.self) { work in
                        HStack {
                            Text(work)
                                .font(.body)
                            Image(systemName: "book.fill")
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.background)
                        .shadow(radius: 2)
                )
                .padding(.horizontal)
            }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(.all, edges: .top)
        .alert(isAddedToFavorites ? "اضافه شد به علاقه‌مندی‌ها" : "حذف شد از علاقه‌مندی‌ها", 
               isPresented: $showAlert) {
            Button("تایید", role: .cancel) { }
        } message: {
            Text(isAddedToFavorites ? 
                "\(poet.name) به لیست شاعران مورد علاقه اضافه شد" :
                "\(poet.name) از لیست شاعران مورد علاقه حذف شد")
        }
    }
}

#Preview {
    NavigationStack {
        PoetProfileView(poet: Poet.samplePoets[0])
    }
} 
