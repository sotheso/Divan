//
//  InputView.swift
//  Divan
//
//  Created by Sothesom on 31/04/1404.
//

import SwiftUI

struct InputView: View {
    
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            Text(title)
                .foregroundColor(Color.gray)
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
            } else {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14)) 
            }
            
            Divider()
            
            
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "email addres", placeholder: "name@example.com")
}
