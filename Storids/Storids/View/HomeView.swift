//
//  HomeView.swift
//  Storids
//
//  Created by srisshar on 20/06/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var bookVM = BookViewModel.shared
    @State var selectedTab: Tab = .fiction
    
    var body: some View {
        NavigationStack {
            ScrollView {
                segmentedControl(selectedTab: $selectedTab)
                if bookVM.isDataLoaded {
                    BookView(selectedTab: $selectedTab, bookData: bookVM.bookData)
                }
                else {
                    ProgressView("Books loading, worlds unfolding...")
                        .padding()
                }
            }
        }
        .onChange(of: selectedTab) {
            bookVM.isDataLoaded = false
            bookVM.getData(for: selectedTab.rawValue)
               }
        .task {
            bookVM.getData(for: selectedTab.rawValue)
           
        }
    }
}

#Preview {
    HomeView()
}
