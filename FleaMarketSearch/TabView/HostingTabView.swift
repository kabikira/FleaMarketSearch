//
//  HostingTabView.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/18.
//

import SwiftUI

struct HostingTabView: View {
    @Binding var isShowView: Bool
    @Binding var word: String
    @StateObject private var merucariStore = WebViewStore()
    @StateObject private var rakumaStore = WebViewStore()
    @StateObject private var yafuokuStore = WebViewStore()
    @StateObject private var paypayStore = WebViewStore()
    @StateObject private var googleStore = WebViewStore()

    var body: some View {
        VStack {
            TabView() {
                MerucariView(store: merucariStore, isShowView: $isShowView, word: $word)
                    .tabItem {
                            Image(systemName: "m.square")
                            Text("メルカリ")
                    }.tag(0)
                RakumaView(store: rakumaStore, isShowView: $isShowView, word: $word)
                    .tabItem {
                        Image(systemName: "r.square")
                        Text("ラクマ")
                    }.tag(1)
                YafuokuView(store: yafuokuStore, isShowView: $isShowView, word: $word)
                    .tabItem {
                            Image(systemName: "y.square")
                            Text("ヤフオク")
                    }.tag(2)
                PaypayView(store: paypayStore, isShowView: $isShowView, word: $word)
                    .tabItem {
                        Image(systemName: "p.square")
                        Text("paypay")
                    }.tag(3)
                GoogleView(store: googleStore, isShowView: $isShowView, word: $word)
                    .tabItem {
                        Image(systemName: "g.square")
                        Text("グーグル")
                    }.tag(4)
            }
            .onAppear(perform: preloadAllWebViews)
            .onChange(of: word) { _ in
                preloadAllWebViews()
            }
        }
    }
}

private extension HostingTabView {
    func preloadAllWebViews() {
        let encodedWord = word.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""

        merucariStore.loadIfNeeded(urlString: "https://jp.mercari.com/search?keyword=" + encodedWord)
        rakumaStore.loadIfNeeded(urlString: "https://fril.jp/s?query=" + encodedWord)
        yafuokuStore.loadIfNeeded(urlString: "https://auctions.yahoo.co.jp/search/search?aq=-1&auccat=&ei=utf-8&fr=auc_top&oq=&p=" + encodedWord)

        let paypayURL: String
        if encodedWord.isEmpty {
            paypayURL = "https://paypayfleamarket.yahoo.co.jp"
        } else {
            paypayURL = "https://paypayfleamarket.yahoo.co.jp/search/" + encodedWord
        }
        paypayStore.loadIfNeeded(urlString: paypayURL)

        googleStore.loadIfNeeded(urlString: "https://www.google.com/search?q=" + encodedWord)
    }
}

//struct HostingTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        HostingTabView()
//    }
//}
