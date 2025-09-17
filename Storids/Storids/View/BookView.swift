//
//  BookView.swift
//  Storids
//
//  Created by srisshar on 20/06/24.
//

import SwiftUI

struct Books: View {
    var theBook: Book
    var body: some View {
        AsyncImage(url: URL(string: theBook.imageUrl)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 176, height: 260)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            case .success(let image):
                image.resizable()
                    .scaledToFill()
                    .frame(width: 176, height: 260)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(alignment: .bottom) {
                        UnevenRoundedRectangle(bottomLeadingRadius: 12, bottomTrailingRadius: 12)
                            .frame(height: 40)
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .leading, endPoint: .trailing))
                        Text(theBook.title).bold()
                            .foregroundStyle(.white)
                            .frame(width: 150, alignment: .leading)
                    }
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 176, height: 260)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            @unknown default:
                EmptyView()
            }
        }
    }
}


//#Preview {
//    BookView()
//}

struct BookView: View {
    
    @Binding var selectedTab: Tab
    var bookData: [Book]
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 2), content: {
            ForEach(bookData, id: \.id) { book in
                NavigationLink(destination: SelectedView(theBook: book)) {
                    Books(theBook: book)
                }
            }
        })
    }
}
