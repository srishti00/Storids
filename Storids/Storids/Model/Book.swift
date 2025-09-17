//
//  Book.swift
//  Storids
//
//  Created by srisshar on 26/06/24.
//

import Foundation

enum Tab: String,CaseIterable {
    case fiction = "fiction"
    case mystery = "mystery"
    case romance = "romance"
    case action = "action"
    case comedy = "comedy" 
    case religion = "religion"
    case history = "History"
    case music = "Music"
    case law = "Law"
    case social_science = "Social Science"
}

struct Book {
    var id: String
    var title: String
    var authors: String
    var description: String
    var imageUrl: String
    var webUrl: String
    //var rating: Double
    var publishedDate: String
    var pageCount: String
    var language: String
    var saleability: String
    var price: String
}
