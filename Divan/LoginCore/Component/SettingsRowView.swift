//
//  SettingsRowView.swift
//  Divan
//
//  Created by Sothesom on 31/04/1404.
//

import SwiftUI

struct SettingsRowView: View {

    let imagName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack(spacing: 12){
            Image(systemName: imagName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(tintColor)
        }
    }
}

#Preview {
    SettingsRowView(imagName: "gear", title: "version", tintColor: Color(.systemGray))
}
