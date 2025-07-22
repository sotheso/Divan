import SwiftUI

struct AboutUsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .trailing, spacing: 16) {
                Text("درباره دیوان")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                Text("""
                    اپلیکیشن دیوان با هدف دسترسی آسان به اشعار شاعران بزرگ پارسی‌گو طراحی و پیاده‌سازی شده است.
                    
                    در این نسخه، امکان مطالعه و جستجو در اشعار حافظ و باباطاهر فراهم شده است. در نسخه‌های بعدی، اشعار شاعران دیگر نیز اضافه خواهد شد.
                    
                    ویژگی‌های اصلی:
                    • جستجو در اشعار
                    • ذخیره اشعار مورد علاقه
                    • اشتراک‌گذاری اشعار
                    • پشتیبانی از حالت تاریک
                    
                    برای پیشنهادات و انتقادات خود می‌توانید با ما در ارتباط باشید:
                    """)
                .multilineTextAlignment(.trailing)
                .padding(.bottom)
                
                Link("Sothesom@gmail.com", destination: URL(string: "mailto:Sothesom@gmail.com")!)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(.bottom)
            }
            .padding()
            
            
            Spacer()
            // Apple Podcast Banner
            Link(destination: URL(string: "https://podcasts.apple.com/us/podcast/الا-یا-ایها-الساقی-۰۱/id1459918086?i=1000650652264")!) {
                HStack {
                    Image("Ravagh")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    
                    Spacer()
                    
                    Text("گوش دادن حافظ در صدای سخن عشق")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    Spacer()
                    
                    Image("Podcasts")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(red: 170/255, green: 197/255, blue: 216/255), Color(red: 183/255, green: 75/255, blue: 222/255)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(12)

            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .navigationTitle("About Us")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        AboutUsView()
    }
} 
