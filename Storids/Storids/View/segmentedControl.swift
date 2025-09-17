//
//  segmentedControl.swift
//  Storids
//
//  Created by srisshar on 20/06/24.
//

import SwiftUI

struct segmentedControl: View {
    @Binding var selectedTab: Tab
    @State var textWidth: CGFloat = 0
    @State var textWidths: [CGFloat] = Array(repeating: 0, count: Tab.allCases.count)
    @State var indexInt: CGFloat = 0
    @State var hstackWidth: CGFloat = 0
    
    var body: some View {
        
        ScrollViewReader(content: { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(Tab.allCases.indices, id: \.self) { index in
                        let tab = Tab.allCases[index]
                        Text(tab.rawValue).font(.callout)
                            .background {
                                GeometryReader(content: { textGeoWidth -> Color in
                                    DispatchQueue.main.async {
                                        textWidths[index] = textGeoWidth.size.width
                                    }
                                    return Color.clear
                                })
                            }
                            .id(index)
                            .foregroundColor(selectedTab == tab ? .primary : .secondary)
                            .frame(width: 70, alignment: .leading)
                            .padding(.vertical,10)
                            .onTapGesture {
                                withAnimation {
                                    indexInt = CGFloat(index)
                                    textWidth = textWidths[index]
                                    selectedTab = tab
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    withAnimation {
                                        proxy.scrollTo(index, anchor: .center)
                                    }
                                }
                            }
                    }
                }
                .background {
                    GeometryReader(content: { geometry in
                        Capsule()
                            .opacity(0.3)
                            .frame(width: textWidth + 30)
                            .offset(x: indexInt * 100)
                            .offset(x: -15)
                    })
                }
                .padding(.horizontal, 15)
            }
            .onAppear() {
                if textWidth == 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        textWidth = textWidths[0]
                    }
                }
            }
        })
    }
}

//#Preview {
//    segmentedControl()
//}


