//
//  BookListView.swift
//  DivanTest
//
//  Created by Sothesom on 15/02/1404.
//

import SwiftUI

struct BookListView: View {
    @StateObject private var bookModel = BookModel()
    @State private var searchText = ""
    var poet: Poet? = nil
    
    var filteredBooks: [Book] {
        var books = bookModel.books
        
        if let poet = poet {
            books = books.filter { $0.poetType == poet.type }
        }
        
        if !searchText.isEmpty {
            books = books.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.author.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return books
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(poet == nil ? "کتاب‌های پیشنهادی" : "کتاب‌های \(poet!.name)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color("Color"))
                .padding(.horizontal)
                .padding(.top, 20)
            
            if filteredBooks.isEmpty {
                Text("هیچ کتابی یافت نشد")
                    .foregroundStyle(.gray)
                    .padding()
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(filteredBooks) { book in
                            BookCardView(book: book)
                        }
                    }
                }
                .ignoresSafeArea(.container, edges: .horizontal)
            }
        }
        .padding(.top, 20)
    }
}

struct BookCardView: View {
    let book: Book
    
    var body: some View {
        NavigationLink(destination: SearchView(selectedCategory: book.category)) {
            ZStack(alignment: .center) {
                // Book Image with fallback
                if let uiImage = UIImage(named: book.imageName) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    Image("‌Book1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                // Text
                VStack(spacing: 4) {
                    Text(book.title)
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
                    
                    Text(book.author)
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.9))
                        .lineLimit(1)
                        .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 8)
            }
            .frame(width: 160, height: 240)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(
                color: Color("AccentColor").opacity(0.3),
                radius: 8,
                x: 0,
                y: 4
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    BookListView()
}
