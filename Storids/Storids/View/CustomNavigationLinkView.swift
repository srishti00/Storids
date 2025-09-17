//
//  CustomNavigationLinkView.swift
//  Storids
//
//  Created by srisshar on 26/06/24.
//

import Foundation
import SwiftUI

struct CustomNavigationLinkView<Content:View> : View {
    @Environment(\.dismiss) var dismiss
    var title: String
    var content: Content
    @State var Yoffset: CGFloat = 0
    
    init(title: String,@ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        content
        .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    backButton
                }
            })
    }
    
    private var backButton: some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: "chevron.left").bold()
                .frame(width: 40, height: 40)
                .background(.ultraThinMaterial, in: Circle())
                .foregroundStyle(.black)
        }
    }
}
