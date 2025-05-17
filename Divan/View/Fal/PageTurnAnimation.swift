import SwiftUI
import AVFoundation

struct PageTurnAnimation: View {
    @Binding var isAnimating: Bool
    @State private var rotation: Double = 0
    @State private var opacity: Double = 0
    @State private var scale: CGFloat = 0.8
    
    // سیستم پخش صدا
    private let audioPlayer: AVAudioPlayer?
    
    init(isAnimating: Binding<Bool>) {
        self._isAnimating = isAnimating
        
        // بارگذاری فایل صوتی
        if let soundURL = Bundle.main.url(forResource: "02", withExtension: "wav") {
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                self.audioPlayer?.prepareToPlay()
            } catch {
                print("Error loading audio: \(error.localizedDescription)")
                self.audioPlayer = nil
            }
        } else {
            print("Audio file 02.wav not found. Search path: \(Bundle.main.bundlePath)")
            self.audioPlayer = nil
        }
    }
    
    var body: some View {
        ZStack {
            // پس‌زمینه تیره نیمه‌شفاف
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .opacity(opacity)
            
            // تصویر کتاب و ورق زدن
            VStack {
                Image(systemName: "book.pages")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(rotation))
                    .scaleEffect(scale)
                
                Text("Loading...")                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.top)
            }
            .opacity(opacity)
        }
        .onChange(of: isAnimating) { _, newValue in
            if newValue {
                startAnimation()
            }
        }
    }
    
    private func startAnimation() {
        // پخش صدای ورق زدن
        audioPlayer?.play()
        
        // شروع انیمیشن با ظاهر شدن
        withAnimation(.easeIn(duration: 0.3)) {
            opacity = 1.0
            scale = 1.0
        }
        
        // انیمیشن ورق زدن
        withAnimation(.easeInOut(duration: 1.5)) {
            rotation = 360
        }
        
        // اتمام انیمیشن و ناپدید شدن
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            withAnimation(.easeOut(duration: 0.3)) {
                opacity = 0
                scale = 0.8
            }
            
            // ریست کردن وضعیت انیمیشن
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                rotation = 0
                isAnimating = false
            }
        }
    }
}

#Preview {
    PageTurnAnimation(isAnimating: .constant(true))
} 
