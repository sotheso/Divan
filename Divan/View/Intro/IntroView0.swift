//
//  Intro.swift
//  
//
//  Created by Sothesom on 09/10/1403.
//

import SwiftUI
// Your imports remain the same

struct IntroView0: View {
    // No external bindings; intro completion handled via @AppStorage in IntroView1
    
    var body: some View {
        IntroView1()
            .environment(\.colorScheme, .dark)
    }
}

// Update Preview
#Preview {
    IntroView0()
}
