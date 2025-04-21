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
            VStack(spacing: 16) {
                // Header Image & Info
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
                        
                        // Back Button
                        HStack {
                            Button(action: { dismiss() }) {
                                HStack {
                                    Image(systemName: "chevron.backward")
                                    Text("بازگشت")
                                }
                                .foregroundStyle(.white)
                                .padding(8)
                                .background(Color("AccentColor").opacity(0.3))
                                .clipShape(Capsule())
                            }
                            Spacer()
                        }
                        .padding(.top, 50)
                        .padding()
                        
                        // Bottom Gradient & Info
                        VStack {
                            Spacer()
                            LinearGradient(
                                gradient: Gradient(colors: [.black.opacity(0.7), .clear]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                            .frame(height: ((geometry.size.width * 7) / 5) * 4 / 7)
                            .overlay(
                                VStack(spacing: 8) {
                                    HStack {
                                        Button(action: {
                                            isAddedToFavorites = !favoritesManager.isFavorite(poet.id.uuidString)
                                            favoritesManager.toggleFavorite(poetId: poet.id.uuidString)
                                            showAlert = true
                                        }) {
                                            Image(systemName: favoritesManager.isFavorite(poet.id.uuidString) ? "star.fill" : "star")
                                                .foregroundStyle(favoritesManager.isFavorite(poet.id.uuidString) ? Color("Color") : .white)
                                                .font(.title2)
                                                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
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
                                .padding(.bottom, 20),
                                alignment: .bottom
                            )
                        }
                    }
                }
                .frame(height: UIScreen.main.bounds.width * 7 / 5)
                
                // Bio Section
                VStack(alignment: .trailing, spacing: 12) {
                    Text("زندگینامه")
                        .font(.headline)
                        .foregroundStyle(Color("Color"))
                    
                    Text(poet.bio)
                        .font(.body)
                        .multilineTextAlignment(.trailing)
                        .lineSpacing(8)
                }
                .padding()
                .background(Color("Color Back"))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: Color("AccentColor").opacity(0.1), radius: 2)
                .padding(.horizontal)
                
                // Works Section
                VStack(alignment: .trailing, spacing: 12) {
                    Text("آثار")
                        .font(.headline)
                        .foregroundStyle(Color("Color"))
                    
                    ForEach(poet.works, id: \.self) { work in
                        HStack {
                            Text(work)
                                .font(.body)
                            Image(systemName: "book.fill")
                                .foregroundStyle(Color("Color"))
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .padding()
                .background(Color("Color Back"))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: Color("AccentColor").opacity(0.1), radius: 2)
                .padding(.horizontal)
            }
            .padding(.bottom, 20)
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
