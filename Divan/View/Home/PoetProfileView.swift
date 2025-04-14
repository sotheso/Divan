// ProfileView شاعران
// 1404/01/24




import SwiftUI


struct PoetProfileView: View {
    let poet: Poet
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Profile Image and Name
                VStack(spacing: 16) {
                    Image(poet.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.primary.opacity(0.2), lineWidth: 2)
                        )
                        .shadow(radius: 5)
                    
                    Text(poet.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("\(poet.birthPlace) - \(poet.birthYear) تا \(poet.deathYear)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 20)
                
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
            .padding(.bottom, 20)
        }
        .navigationTitle("پروفایل شاعر")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PoetProfileView(poet: Poet.samplePoets[0])
    }
} 
