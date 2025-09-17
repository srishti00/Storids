//
//  SelectedView.swift
//  Storids
//
//  Created by srisshar on 21/06/24.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct SelectedView: View {
    var theBook: Book
    @State var showTheStory = false
    private let characterLimit = 250
    
    var body: some View {
        CustomNavigationLinkView(title: theBook.title) {
            ZStack {
                GeometryReader(content: { geometry in
                    AsyncImage(url: URL(string: theBook.imageUrl)) { phase in
                        switch phase {
                        case .success(let image):
                            image.resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                            
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 50)
                        case .empty:
                            ProgressView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                })
                VStack(alignment: .leading, spacing: 24) {
                    Text(theBook.title).font(.title).bold()
                        .foregroundStyle(.white)
                    
                    HStack {
                        Text("by \(theBook.authors)")
                        line()
                        Text("publish \(theBook.publishedDate)")
                    }
                    .foregroundStyle(.secondary)
                    HStack {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Language").foregroundStyle(.secondary)
                            Text(theBook.language).bold()
                        }
                        Spacer()
                        line()
                        VStack(alignment: .leading, spacing: 15) {
                            let price = theBook.price != "" ? theBook.price : "0.00"
                            Text("Price").foregroundStyle(.secondary)
                            Text("₹\(price)").bold()
                        }
                        Spacer()
                        line()
                        VStack(alignment: .leading, spacing: 15) {
                            Text("PAGES").foregroundStyle(.secondary)
                            Text(theBook.pageCount).bold()
                        }
                    }
                    Text(truncatedDescription(theBook.description, limit: characterLimit))
                        .foregroundStyle(.secondary)
                }
                .padding()
                .padding(.vertical, 20)
                .padding(.bottom, 60)
                .background(.ultraThinMaterial)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .overlay(alignment: .bottom) {
                    NavigationLink(destination: BookPreviewView(urlString: theBook.webUrl)) {
                        Text("Start Reading").bold()
                            .frame(width: 250, height: 50)
                            .background(.white, in: .capsule)
                            .foregroundStyle(.black)
                    }
                    .padding(.bottom,25)
                }
            }.ignoresSafeArea()
        }
    }
    
    private func truncatedDescription(_ description: String, limit: Int) -> String {
           if description.count <= limit {
               return description
           }
           let endIndex = description.index(description.startIndex, offsetBy: limit)
           var truncated = String(description[..<endIndex])
           if let lastSpaceIndex = truncated.lastIndex(of: " ") {
               truncated = String(truncated[..<lastSpaceIndex])
           }
           if !truncated.hasSuffix(".") {
               truncated.append(".")
           }
           return truncated
       }
    
}

#Preview {
    SelectedView(theBook: Book(id: "id", title: "Ignite Me (Shatter Me)", authors: "Tahereh Mafi", description: "X-Men meets The Handmaid\'s Tale in the third instalment in an epic and romantic YA fantasy trilogy perfect for fans of Netflix\'s Stranger Things, Sarah J. Maas, Victoria Aveyard\'s The Red Queen and Leigh Bardugo\'s Six of Crows..", imageUrl: "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1375972497i/13188676.jpg", webUrl: "http://play.google.com/books/reader?id=CEbMEAAAQBAJ&hl=&source=gbs_api", publishedDate: "08-06-2024", pageCount: "245", language: "en", saleability: "For sale", price: "289"))
}

struct line: View {
    var body: some View {
        Rectangle()
            .frame(width: 1, height: 35)
    }
}
