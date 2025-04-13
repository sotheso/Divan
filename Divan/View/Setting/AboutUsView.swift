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
        }
        .navigationTitle("درباره ما")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        AboutUsView()
    }
} 
