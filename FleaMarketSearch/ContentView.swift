//
//  ContentView.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/13.
//

import SwiftUI

struct ContentView: View {
    @State var isShowingView: Bool = false
    @State var word = ""
    @State var words: [String] = []
    @State var showingSheet: Bool = false
    
    var userDefaultsOp = UserDefaultsOp()
    var body: some View {
        VStack {
            
            if isShowingView {
                HostingTabView(isShowView: $isShowingView, word: $word)
            } else {
                VStack {
                    VStack {
                        Text("フリマ検索")
                                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    }
                    SearchScreenView(word: $word)
                    Spacer()
                        .frame(height: 20)
                    HStack {
                        SearchButtonView(word: $word, words: $words, showingSheet: $showingSheet, isShowingView: $isShowingView, userDefaultsOp: userDefaultsOp)
                    }
                }
                Spacer()
                    .frame(height: 250)
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
