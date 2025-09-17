//
//  BookPreviewView.swift
//  Storids
//
//  Created by srisshar on 24/06/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct BookPreviewView: View {
    let urlString: String

    var body: some View {
        CustomNavigationLinkView(title: "Book Preview") {
            if let url = URL(string: urlString) {
                WebView(url: url)
                    .navigationTitle("Book Preview")
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                Text("Invalid URL")
                    .foregroundColor(.red)
                    .navigationTitle("Error")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

