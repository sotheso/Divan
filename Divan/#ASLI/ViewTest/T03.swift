//
//  T03.swift
//  TestDiv
//
//  Created by Sothesom on 20/01/1404.
//

import SwiftUI

struct T03: View {
    var body: some View {
        ZStack {
            // مربع ساده با گوشه‌های گرد و زاویه 45 درجه
            RoundedRectangle(cornerRadius: 80)
                .frame(width: 450, height: 280)
                .foregroundColor(Color(red: 0.9, green: 0.2, blue: 0.3))
                .rotationEffect(.degrees(20))
                .offset(x: 20, y:-370)
        }
    }
}

#Preview {
    T03()
}
