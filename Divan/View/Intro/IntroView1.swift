//
//  IntroView1.swift
//  
//
//  Created by Sothesom on 09/10/1403.
//

import SwiftUI

struct IntroView1: View {
    
    @State private var showingLoginView = false
    @State private var activePage: IntroModel = .page1
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        NavigationStack {
            GeometryReader {
                let size = $0.size
                
                
                VStack {
                    Spacer(minLength: 0)
                    IntroSymbolView(symbol: activePage.rawValue, config: .init(font: .system(size: 150, weight: .bold), frame: .init(width: 250, height: 200), radio:30, forgroudColor: .white))
                    
                    TexContents(size: size)
                    
                    Spacer(minLength: 0)
                    
                    IndicatorView()
                    
                    ContinueButton()
                }
                .frame(maxWidth: .infinity)
                .overlay(alignment: .top) {
                    HeaderView()
                }
            }
            .background{
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0x7E/255, green: 0x5B/255, blue: 0x26/255),
                                Color(red: 0x1B/255, green: 0x13/255, blue: 0x08/255)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .ignoresSafeArea()
            }
        }
    }
    
    @ViewBuilder
    func TexContents(size: CGSize) -> some View {
        VStack(spacing: 8){
            HStack(alignment: .top, spacing: 0){
                ForEach(IntroModel.allCases, id: \.rawValue){ page in
                    Text(page.title)
                        .lineLimit(1)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .kerning(1.1)
                        .frame(width: size.width)
                        .foregroundStyle(.white)
                }
            }
            .offset(x: -activePage.index * size.width)
            .animation(.spring(duration: 0.7, bounce: 0.2), value: activePage)
            
            HStack(alignment: .top, spacing: 0){
                ForEach(IntroModel.allCases, id: \.rawValue){ page in
                    Text(page.subTitel)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(width: size.width)
                        .foregroundStyle(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                }
            }
            .offset(x: -activePage.index * size.width)
            .animation(.spring(duration: 0.7, bounce: 0.2), value: activePage)
        }
        .padding(.top, 15)
        .frame(width: size.width, alignment: .leading)
    }
    
    @ViewBuilder
    func IndicatorView() -> some View{
        HStack(spacing: 6){
            ForEach(IntroModel.allCases, id: \.rawValue) { page in
                Capsule()
                    .fill(.white.opacity(activePage == page ? 1 : 0.4))
                    .frame(width: activePage == page ? 25 : 8, height: 8)
            }
        }
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: activePage)
        .padding(.bottom, 12)
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        HStack {
            Button {
                withAnimation(.spring(duration: 0.5)) {
                    activePage = activePage.previousPage
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .contentShape(.rect)
            }
            .opacity(activePage != .page1 ? 1 : 0)
            
            Spacer(minLength: 0)
            
            Button("رد کردن") {
                withAnimation(.spring(duration: 0.5)) {
                    activePage = .page5
                }
            }
            .fontWeight(.semibold)
            .opacity(activePage != .page5 ? 1 : 0)
        }
        .foregroundStyle(.white)
        .animation(.spring(duration: 0.5), value: activePage)
        .padding(15)
    }
    
    @ViewBuilder
    func ContinueButton() -> some View {
        Button {
            if activePage == .page5 {
                isLoggedIn = true
            } else {
                activePage = activePage.nextPage
            }
        } label: {
            Text(activePage == .page5 ? "شروع کنید" : "ادامه")
                .contentTransition(.identity)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.vertical, 12)
                .frame(maxWidth: 370)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(.bottom, 15)
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: activePage)
    }
}

#Preview {
    IntroView1(isLoggedIn: .constant(false))
}
