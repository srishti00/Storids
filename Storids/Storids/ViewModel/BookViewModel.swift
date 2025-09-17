//
//  BookViewModel.swift
//  Storids
//
//  Created by srisshar on 20/06/24.
//

import Foundation
import SwiftyJSON

class BookViewModel: ObservableObject {
    
    static let shared = BookViewModel()
    
    @Published var bookData = [Book]()
    @Published var isDataLoaded: Bool = false
    
    func getData(for category: String) {
        self.bookData = []
        self.isDataLoaded = false
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=\(category)"
        let session = URLSession(configuration: .default)
        guard let url = URL(string: urlString) else { return }
        session.dataTask(with: url) {
            (data,_ , error)  in
            if error != nil {
                print((error?.localizedDescription)!)
            }
            do {
                let json = try JSON(data: data!)
                let items = json["items"].arrayValue
                for item in items {
                    let id = item["id"].stringValue
                    let title = item["volumeInfo"]["title"].stringValue
                    let authors = item["volumeInfo"]["authors"].arrayValue.map { $0.stringValue }.joined(separator: ", ")
                    let desc = item["volumeInfo"]["description"].stringValue
                    let webUrl = item["accessInfo"]["webReaderLink"].stringValue
                    let pubDate = item["volumeInfo"]["publishedDate"].stringValue
                    let pages = item["volumeInfo"]["pageCount"].stringValue
                    let lang = item["volumeInfo"]["language"].stringValue
                    let sale = item["saleInfo"]["saleability"].stringValue
                    let imgUrl = "https://books.google.com/books/publisher/content/images/frontcover/\(id)?fife=w400-h600&source=gbs_api"
                    let price = item["saleInfo"]["retailPrice"]["amount"].stringValue
                    DispatchQueue.main.async {
                        if sale != "NOT_FOR_SALE" {
                            self.bookData.append(Book(id: id, title: title, authors: authors, description: desc, imageUrl: imgUrl, webUrl: webUrl, publishedDate: pubDate, pageCount: pages, language: lang, saleability: sale, price: price))
                            self.isDataLoaded = true
                        }
                    }
                    print(self.bookData)
                }
            }
            catch(let error) {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

